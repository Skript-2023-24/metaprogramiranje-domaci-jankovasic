require "google_drive"
require_relative "nova_biblioteka"


session = GoogleDrive::Session.from_config("config.json")

ws = session.spreadsheet_by_key('1Vo4Af8qCG8tmsu7CWVYEKfdl868OGkROoI6cFQC-JZQ').worksheets[0]
p ws[2, 1]  #==> "hoge"

tabela=[]
tabela=NovaBiblioteka.ucita('1Vo4Af8qCG8tmsu7CWVYEKfdl868OGkROoI6cFQC-JZQ')
NovaBiblioteka.ispisi_tabelu(tabela)
p NovaBiblioteka.row(1)
p NovaBiblioteka.each
p NovaBiblioteka.ucita
p NovaBiblioteka.sum
p NovaBiblioteka.avg
p NovaBiblioteka.saberi_tabele
p NovaBiblioteka.oduzmi_tabele