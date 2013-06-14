class PdfController < ApplicationController

  def index
    @html = %Q{
      <html>
        <head><title>Example HTML</title></head>
        <body>
          <h1>HyPDF add-on</h1>

          <div style="background:#E1EAF3;border:1px solid #d0dbe6;border-radius: 3px;color:#4F535D;margin: 0 0 22px 0;padding:12px;">
            HyPDF is an <a href="https://addons.heroku.com/hypdf">add-on</a> for easy and flexible creation of PDF from HTML.
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
    hypdf = HyPDF.new(params[:content], options)

    if params[:commit] == 'Download PDF'
      send_data(hypdf.get, filename: 'hypdf_test.pdf', type: 'application/pdf')
    else
      # NOTE: replace 'hypdf_test' with your backet name
      url = hypdf.upload_to_s3('hypdf_test', 'hypdf_test.pdf', true)
      redirect_to :root, notice: "PDF url: #{url} | Number of pages: #{hypdf.meta[:pages]}"
    end
  end

end
