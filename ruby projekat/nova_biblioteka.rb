require "google_drive"

module NovaBiblioteka
    SPREADSHEET_KEY='1Vo4Af8qCG8tmsu7CWVYEKfdl868OGkROoI6cFQC-JZQ'.freeze

    def self.ucita(key, worksheet_index = 1)
        session = GoogleDrive::Session.from_config('config.json')
        ws = session.spreadsheet_by_key(SPREADSHEET_KEY).worksheets[worksheet_index]
    
        tabela = []
        merged_cells = {}
        ws.rows.each do |row|
          tabela << row
        end
    
        tabela
    end
    
      def self.ispisi_tabelu(tabela)
        tabela.each do |red|
          puts red.join("\t")
        end
      end
    
      def self.row(index)
        session = GoogleDrive::Session.from_config('config.json')
        ws = session.spreadsheet_by_key(SPREADSHEET_KEY).worksheets[0]
        
        row = ws.rows[index-1]
        
        row
      end

      def self.each(&block)
        tabela = ucita(SPREADSHEET_KEY)
        tabela.each(&block)
      end
    
      include Enumerable

      class Kolona
    attr_accessor :tabela, :naziv_kolone

    def initialize(tabela, naziv_kolone)
      @tabela = tabela
      @naziv_kolone = naziv_kolone
    end

    def [](indeks)
      session = GoogleDrive::Session.from_config('config.json')
      ws = session.spreadsheet_by_key(SPREADSHEET_KEY).worksheets[0]
      ws.rows.transpose[ws.rows.first.index(@naziv_kolone)][indeks]
    end

    def []=(indeks, vrednost)
      session = GoogleDrive::Session.from_config('config.json')
      ws = session.spreadsheet_by_key(SPREADSHEET_KEY).worksheets[0]
      kolona_indeks = ws.rows.first.index(@naziv_kolone)
      ws[indeks, kolona_indeks + 1] = vrednost
      ws.save
      ws.reload
    end
  end
  def self.sum(indeks_kolone)
    kolona = column(indeks_kolone)
    kolona.sum if kolona.any?
  end
 
  def self.avg(indeks_kolone)
    kolona = column(indeks_kolone)
    kolona.sum if kolona.any?
  end
  def self.saberi_tabele(tabela1, tabela2)
    return nil unless tabela1[0] == tabela2[0] 
 
    tabela1 + tabela2[1..-1] 
  end
 
  def self.oduzmi_tabele(tabela1, tabela2)
    return nil unless tabela1[0] == tabela2[0] 
 
    header = tabela1[0]
    nova_tabela = [header]
 
    tabela1.each_with_index do |red1, index1|
      next if index1.zero? 
 
      duplicate = false
 
      tabela2.each_with_index do |red2, index2|
        next if index2.zero? 
 
        if red1 == red2
          duplicate = true
          break
        end
      end
 
      nova_tabela << red1 unless duplicate
    end
 
    nova_tabela
  end
end
