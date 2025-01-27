require './lib/exhibit'
require './lib/patron'
require './lib/museum'
require 'rspec'

RSpec.describe Museum do

  before :each do
    @dmns = Museum.new("Denver Museum of Nature and Science")
    @gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    @dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    @imax = Exhibit.new({name: "IMAX",cost: 15})

    @patron_1 = Patron.new("Bob", 0)
    @patron_2 = Patron.new("Sally", 20)
    @patron_3 = Patron.new("Johnny", 5)
  end


  it 'exists' do
    expect(@dmns).to be_an_instance_of(Museum)
  end

  it 'has a name' do
    expect(@dmns.name).to eq("Denver Museum of Nature and Science")
  end

  it 'has no exhibits by default' do
    expect(@dmns.exhibits).to eq([])
  end

  it 'can add exhibits' do
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    expect(@dmns.exhibits).to eq([@gems_and_minerals, @dead_sea_scrolls, @imax])
  end


  it 'can recommended exhibits' do
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @patron_1.add_interests("Dead Sea Scrolls")
    @patron_1.add_interests("Gems and Minerals")
    @patron_2.add_interests("IMAX")

    expect(@dmns.recommend_exhibits(@patron_1)).to eq([@gems_and_minerals, @dead_sea_scrolls])
    expect(@dmns.recommend_exhibits(@patron_2)).to eq([@imax])
  end

  it 'can have patrons' do
    expect(@dmns.patrons).to eq([])
  end

  it 'can admit patrons to the exhibits' do
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @patron_1.add_interests("Dead Sea Scrolls")
    @patron_1.add_interests("Gems and Minerals")
    @patron_2.add_interests("Dead Sea Scrolls")
    @patron_3.add_interests("Dead Sea Scrolls")

    @dmns.admit(@patron_1)
    @dmns.admit(@patron_2)
    @dmns.admit(@patron_3)

    expect(@dmns.patrons_by_exhibit_interest).to eq({@gems_and_minerals => [@patron_1], @dead_sea_scrolls => [@patron_1, @patron_2, @patron_3], @imax => []})
  end

  it 'dead sea scrolls has lottery ticket contestants' do
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @patron_1.add_interests("Dead Sea Scrolls")
    @patron_1.add_interests("Gems and Minerals")
    @patron_2.add_interests("Dead Sea Scrolls")
    @patron_3.add_interests("Dead Sea Scrolls")

    @dmns.admit(@patron_1)
    @dmns.admit(@patron_2)
    @dmns.admit(@patron_3)

    expect(@dmns.ticket_lottery_contestants(@dead_sea_scrolls)).to eq([@patron_1, @patron_3])
    expect(@dmns.ticket_lottery_contestants(@gems_and_minerals)).to eq([])
    expect(@dmns.ticket_lottery_contestants(@imax)).to eq([])
  end

  it 'dead sea scrolls can draw a lottery winner' do
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @patron_1.add_interests("Dead Sea Scrolls")
    @patron_1.add_interests("Gems and Minerals")
    @patron_2.add_interests("Dead Sea Scrolls")
    @patron_3.add_interests("Dead Sea Scrolls")

    @dmns.admit(@patron_1)
    @dmns.admit(@patron_2)
    @dmns.admit(@patron_3)

    expect(@dmns.draw_lottery_winner(@dead_sea_scrolls)).to eq('Bob').or(eq('Johnny'))
    expect(@dmns.draw_lottery_winner(@gems_and_minerals)).to eq(nil)
    expect(@dmns.draw_lottery_winner(@imax)).to eq(nil)
  end

  it 'can annouce lottery ticket winners' do
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @patron_1.add_interests("Dead Sea Scrolls")
    @patron_1.add_interests("Gems and Minerals")
    @patron_2.add_interests("Dead Sea Scrolls")
    @patron_3.add_interests("Dead Sea Scrolls")

    @dmns.admit(@patron_1)
    @dmns.admit(@patron_2)
    @dmns.admit(@patron_3)

    allow(@dmns).to receive(:draw_lottery_winner).and_return('Bob')
    expect(@dmns.announce_lottery_winner(@dead_sea_scrolls)).to eq('Bob has won the Dead Sea Scrolls exhibit lottery!')
  end

  it 'will announce if there are no lottery winners' do
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @patron_1.add_interests("Dead Sea Scrolls")
    @patron_1.add_interests("Gems and Minerals")
    @patron_2.add_interests("Dead Sea Scrolls")
    @patron_3.add_interests("Dead Sea Scrolls")

    @dmns.admit(@patron_1)
    @dmns.admit(@patron_2)
    @dmns.admit(@patron_3)

    allow(@dmns).to receive(:draw_lottery_winner).and_return(nil)
    expect(@dmns.announce_lottery_winner(@gems_and_minerals)).to eq('No lottery winners!')
    expect(@dmns.announce_lottery_winner(@imax)).to eq('No lottery winners!')
  end
end
