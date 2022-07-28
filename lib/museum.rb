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
    patrons_by_interest = Hash.new(0)

    @exhibits.each do |exhibit|
      patrons_by_interest[exhibit] = @patrons.select{|patron| patron.interests.include?(exhibit.name)}.uniq
    end
    patrons_by_interest
  end

  def ticket_lottery_contestants(exhibit)
    patrons_by_exhibit_interest[exhibit].find_all do |patron|
      patron.spending_money < exhibit.cost
    end
  end

  def draw_lottery_winner(exhibit)
    ticket_lottery_contestants(exhibit).sample(1)
  end

  def announce_lottery_winner(exhibit)
    if draw_lottery_winner == true
      puts "#{draw_lottery_winner(exhibit)} has won the #{exhibit} exhibit lottery!"
    end
  end
end
