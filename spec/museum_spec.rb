require './lib/exhibit'
require './lib/patron'
require './lib/museum'
require 'rspec'

RSpec.describe Museum do
  it 'exists' do
    dmns = Museum.new("Denver Museum of Nature and Science")

    expect(dmns).to be_an_instance_of(Museum)
  end

  it 'has a name' do
    dmns = Museum.new("Denver Museum of Nature and Science")

    expect(dmns.name).to eq("Denver Museum of Nature and Science")
  end

  it 'has no exhibits by default' do
    dmns = Museum.new("Denver Museum of Nature and Science")

    expect(dmns.exhibits).to eq([])
  end

  it 'can add exhibits' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    expect(dmns.exhibits).to eq([gems_and_minerals, dead_sea_scrolls, imax])
  end
  it 'has no patrons by default' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    expect(dmns.patrons).to eq([])
  end

  it 'can have patrons' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    patron_1 = Patron.new("Bob", 20)
    patron_2 = Patron.new("Sally", 20)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    dmns.add_patrons(patron_1)
    dmns.add_patrons(patron_2)

    patron_1.add_interests("Dead Sea Scrolls")
    patron_1.add_interests("Gems and Minerals")
    patron_2.add_interests("IMAX")

    expect(dmns.patrons).to eq([patron_1, patron_2])
  end

  it 'can recommended exhibits' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    patron_1 = Patron.new("Bob", 20)
    patron_2 = Patron.new("Sally", 20)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    dmns.add_patrons(patron_1)
    dmns.add_patrons(patron_2)

    patron_1.add_interests("Dead Sea Scrolls")
    patron_1.add_interests("Gems and Minerals")
    patron_2.add_interests("IMAX")

    expect(dmns.recommend_exhibits(patron_1)).to eq([gems_and_minerals, dead_sea_scrolls])
    expect(dmns.recommend_exhibits(patron_2)).to eq([imax])
  end

  it 'can admit patrons to the exhibits' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    patron_1 = Patron.new("Bob", 20)
    patron_2 = Patron.new("Sally", 20)
    patron_3 = Patron.new("Johnny", 5)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    dmns.add_patrons(patron_1)
    dmns.add_patrons(patron_2)
    dmns.add_patrons(patron_3)

    patron_1.add_interests("Dead Sea Scrolls")
    patron_1.add_interests("Gems and Minerals")
    patron_2.add_interests("Dead Sea Scrolls")
    patron_3.add_interests("Dead Sea Scrolls")

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    expect(dmns.patrons).to eq([patron_1, patron_2, patron_3])
    expect(dmns.patrons_by_exhibit_interest).to eq({"Gems and Minerals" => [patron_1], "Dead Sea Scrolls" => [patron_1, patron_2, patron_3], "IMAX" => []})
  end

  it 'dead sea scrolls has lottery ticket contestants' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    patron_1 = Patron.new("Bob", 20)
    patron_2 = Patron.new("Sally", 20)
    patron_3 = Patron.new("Johnny", 5)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    dmns.add_patrons(patron_1)
    dmns.add_patrons(patron_2)
    dmns.add_patrons(patron_3)

    patron_1.add_interests("Dead Sea Scrolls")
    patron_1.add_interests("Gems and Minerals")
    patron_2.add_interests("Dead Sea Scrolls")
    patron_3.add_interests("Dead Sea Scrolls")

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    expect(dmns.ticket_lottery_contestants(dead_sea_scrolls)).to eq([patron_1, patron_3])
  end

  it 'dead sea scrolls can draw a lottery winner' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    patron_1 = Patron.new("Bob", 20)
    patron_2 = Patron.new("Sally", 20)
    patron_3 = Patron.new("Johnny", 5)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    dmns.add_patrons(patron_1)
    dmns.add_patrons(patron_2)
    dmns.add_patrons(patron_3)

    patron_1.add_interests("Dead Sea Scrolls")
    patron_1.add_interests("Gems and Minerals")
    patron_2.add_interests("Dead Sea Scrolls")
    patron_3.add_interests("Dead Sea Scrolls")

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    expect(dmns.draw_lottery_winner(dead_sea_scrolls)).to eq()
  end

  it 'gems has no lottery winner by default' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    patron_1 = Patron.new("Bob", 20)
    patron_2 = Patron.new("Sally", 20)
    patron_3 = Patron.new("Johnny", 5)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    dmns.add_patrons(patron_1)
    dmns.add_patrons(patron_2)
    dmns.add_patrons(patron_3)

    patron_1.add_interests("Dead Sea Scrolls")
    patron_1.add_interests("Gems and Minerals")
    patron_2.add_interests("Dead Sea Scrolls")
    patron_3.add_interests("Dead Sea Scrolls")

    expect(dmns.draw_lottery_winner(gems_and_minerals)).to eq([])
  end

  it 'imax can annouce lottery ticket winners' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    patron_1 = Patron.new("Bob", 20)
    patron_2 = Patron.new("Sally", 20)
    patron_3 = Patron.new("Johnny", 5)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    dmns.add_patrons(patron_1)
    dmns.add_patrons(patron_2)
    dmns.add_patrons(patron_3)

    patron_1.add_interests("Dead Sea Scrolls")
    patron_1.add_interests("Gems and Minerals")
    patron_2.add_interests("Dead Sea Scrolls")
    patron_3.add_interests("Dead Sea Scrolls")

    expect(dmns.announce_lottery_winner(imax)).to eq(patron_1)
  end

  it 'gems can announce lottery winner' do
    dmns = Museum.new("Denver Museum of Nature and Science")
    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})
    patron_1 = Patron.new("Bob", 20)
    patron_2 = Patron.new("Sally", 20)
    patron_3 = Patron.new("Johnny", 5)

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    dmns.add_patrons(patron_1)
    dmns.add_patrons(patron_2)
    dmns.add_patrons(patron_3)

    patron_1.add_interests("Dead Sea Scrolls")
    patron_1.add_interests("Gems and Minerals")
    patron_2.add_interests("Dead Sea Scrolls")
    patron_3.add_interests("Dead Sea Scrolls")

    expect(dmns.announce_lottery_winner(gems_and_minerals)).to eq([])
  end
end
