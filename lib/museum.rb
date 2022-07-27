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

  def patrons_by_exhibit_interest
    patrons_by_interest = Hash.new({})

    i = 0

    @patrons.each do |patron|
      patrons_by_interest[patron] = @exhibits[i]
    end
    patrons_by_interest
  end
end
