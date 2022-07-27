require './lib/exhibit'
require './lib/patron'
require 'rspec'

RSpec.describe Exhibit do
  it 'exists' do
    exhibit = Exhibit.new({name: "Gems and Minerals", cost: 0})

    expect(exhibit).to be_an_instance_of(Exhibit)
  end

  it 'has a name' do
    exhibit = Exhibit.new({name: "Gems and Minerals", cost: 0})

    expect(exhibit.name).to eq("Gems and Minerals")
  end

  it 'has a cost' do
    exhibit = Exhibit.new({name: "Gems and Minerals", cost: 0})

    expect(exhibit.cost).to eq(0)
  end
end
