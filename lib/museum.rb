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
    @recommend_patrons = []

    @exhibits.each do |exhibit|
      exhibit.patrons.each do |patron|
        recommend_patrons << patron.interests if !recommend_patrons.include?(interest.name)
      end
    end
    recommend_patrons
  end
end
