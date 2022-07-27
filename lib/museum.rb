class Museum
  attr_reader :name,
              :exhibits,
              :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []

  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def add_patrons(patron)
    @patrons << patron
  end

  def recommend_exhibits(patron)
   @exhibits.find_all do |exhibit|
     patron.interests.include?(exhibit.name)
   end
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    patrons_by_interest = Hash.new({})

    @exhibits.each do |exhibit|
      @patrons.each do |patron|
        patrons_by_interest[exhibit] = @patrons.select{|patron| patron.interests.any?(exhibit.name)}
      end
    end
    patrons_by_interest
  end
end
