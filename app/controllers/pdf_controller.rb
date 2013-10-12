class PdfController < ApplicationController

  def htmltopdf_page
    @html = %Q{
      <html>
        <head><title>Example HTML</title></head>
        <body>
          <h1>HyPDF add-on</h1>

          <div style="background:#E1EAF3;border:1px solid #d0dbe6;border-radius: 3px;color:#4F535D;margin: 0 0 22px 0;padding:12px;">
            HyPDF is an <a href="https://addons.heroku.com/hypdf">add-on</a> that provides you the full set of tools for working with PDF docuemnts.
          </div>

          <div style="margin:30px 0;-webkit-transform:rotate(5deg);">
            With HyPDF you don't need to learn new programming language or technologies, just use familiar HTML, CSS and JavaScript for creating beautiful and complex PDF documents. Moreover, HyPDF can upload created PDF to your own AWS S3 bucket for you.
          </div>

          <table width="100%">
            <tr>
              <td style="background: red;">Red cell</td>
              <td style="background: green;">Green cell</td>
              <td style="background: blue;">Blue cell</td>
            </tr>
          </table>

          <p>
            Text input: <input name="some_text_field" value="some value" type="text">
            Checkbox: <input name="some_checkbox_field" type="checkbox"> Landscape orientation
          </p>

          <p style="page-break-after:always;">Page breaks after me</p>

          <h1>Second page</h1>
          <p id="js-target">Some text</p>

          <script type="text/javascript">
            var el = document.getElementById('js-target');
            el.innerText = 'Dynamic content!';
          </script>
        </body>
      </html>
    }
  end

  def htmltopdf
    options = (params[:options] || {}).merge(test: true)

    if params[:commit] == 'Download PDF'
      hypdf = HyPDF.htmltopdf(params[:content], options)
      send_data(hypdf[:pdf], filename: 'hypdf_test.pdf', type: 'application/pdf')
    else
      options.merge!(
        bucket: 'hypdf_test', # NOTE: replace 'hypdf_test' with your backet name
        key: 'hypdf_test.pdf',
        public: true
      )
      hypdf = HyPDF.htmltopdf(params[:content], options)
      redirect_to '/htmltopdf', notice: "PDF url: #{hypdf[:url]} | Number of pages: #{hypdf[:pages]}"
    end
  end

  def pdfinfo
    file = params[:file]
    hypdf = HyPDF.pdfinfo(file.path)
    redirect_to '/pdfinfo', notice: "PDF info: #{hypdf}"
  end

  def pdftotext
    file = params[:file]
    options = (params[:options] || {})
    hypdf = HyPDF.pdftotext(file.path, options)
    @text = hypdf[:text]
    render :pdftotext_page
  end

  def pdfextract
    file = params[:file]
    options = (params[:options] || {}).merge(test: true)

    if params[:commit] == 'Download PDF'
      hypdf = HyPDF.pdfextract(file.path, options)
      send_data(hypdf[:pdf], filename: 'hypdf_test.pdf', type: 'application/pdf')
    else
      options.merge!(
        bucket: 'hypdf_test', # NOTE: replace 'hypdf_test' with your backet name
        key: 'hypdf_test.pdf',
        public: true
      )
      hypdf = HyPDF.pdfextract(file.path, options)
      redirect_to '/pdfextract', notice: "PDF url: #{hypdf[:url]}"
    end
  end

  def pdfunite
    file_1 = params[:file_1]
    file_2 = params[:file_2]
    options = {test: true}

    if params[:commit] == 'Download PDF'
      hypdf = HyPDF.pdfunite(file_1.path, file_2.path, options)
      send_data(hypdf[:pdf], filename: 'hypdf_test.pdf', type: 'application/pdf')
    else
      options.merge!(
        bucket: 'hypdf_test', # NOTE: replace 'hypdf_test' with your backet name
        key: 'hypdf_test.pdf',
        public: true
      )
      hypdf = HyPDF.pdfunite(file_1.path, file_2.path, options)
      redirect_to '/pdfunite', notice: "PDF url: #{hypdf[:url]}"
    end
  end

  def async_pdf
    if params[:error]
      puts "##### [#{Time.now}] ERROR: #{params[:message]}"
    else
      puts "##### [#{Time.now}] PDF #{request.headers['hypdf-job-id']} created (#{request.headers['hypdf-pages']} pages): #{params[:url]}"
    end
    render(text: 'ok')
  end

end
