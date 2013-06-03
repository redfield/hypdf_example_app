class PdfController < ApplicationController

  def index
    @html = %Q{
      <html>
        <head><title>Example HTML</title></head>
        <body>
          <h1>HyperPDF add-on</h1>

          <div style="background:#E1EAF3;border:1px solid #d0dbe6;border-radius: 3px;color:#4F535D;margin: 0 0 22px 0;padding:12px;">
            HyperPDF is an <a href="https://addons.heroku.com/hyperpdf">add-on</a> for easy and flexible creation of PDF from HTML.
          </div>

          <div style="margin:30px 0;-webkit-transform:rotate(5deg);">
            With HyperPDF you don't need to learn new programming language or technologies, just use familiar HTML, CSS and JavaScript for creating beautiful and complex PDF documents. Moreover, HyperPDF can upload created PDF to your own AWS S3 bucket for you.
          </div>

          <table width="100%">
            <tr>
              <td style="background: red;">Red cell</td>
              <td style="background: green;">Green cell</td>
              <td style="background: blue;">Blue cell</td>
            </tr>
          </table>

          <p>Text input: <input type="text"></input></p>

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

  def create
    options = (params[:options] || {}).merge(test: true)
    hyperpdf = HyperPDF.new(params[:content], options)

    if params[:commit] == 'Download PDF'
      send_data(hyperpdf.get, filename: 'hyperpdf_test.pdf', type: 'application/pdf')
    else
      # NOTE: replace 'hyperpdf_test' with your backet name
      url = hyperpdf.upload_to_s3('hyperpdf_test', 'hyperpdf_test.pdf', true)
      redirect_to :root, notice: "PDF url: #{url} | Number of pages: #{hyperpdf.meta[:pages]}"
    end
  end

end
