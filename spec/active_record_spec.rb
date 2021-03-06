require 'spec_helper'

describe ActiveRecord do
  before :each do
    EnvHelper.enable_test_env
    Client.reset
  end

  let(:client) do
    Client.new(
      'Marijus',
      'Siliunas',
      '0037061234567',
      'mail@localhost'
    )
  end
  let(:computer) { Computer.new('ASDF1230', {}, client) }

  context 'changes filename according to environment' do
    it do
      EnvHelper.enable_prod_env
      expect(Client.dump_filename).to eq 'storage/Client.yml'
    end
    it do
      EnvHelper.enable_test_env
      expect(Client.dump_filename).to eq 'spec/storage/Client.yml'
    end
  end

  it 'should have numerical id' do
    @instance = client
    expect(@instance.id).to be_instance_of Fixnum
  end

  it 'should not have the same id when having two instances' do
    expect(client.id).not_to eq Client.new('Anas', 'Ponas', '1234', '@here').id
  end

  it 'should have different increment for different classes' do
    expect { computer }.to_not change(Order, :increment)
  end

  it 'should be able to get the same intance by id' do
    @instance = client
    expect(Client.get(@instance.id)).to eq @instance
  end

  it 'should increase count when new instance is created' do
    expect { client }.to change(Client, :count).by(1)
  end

  it 'should decrease count when instance is deleted' do
    instance = client

    expect { instance.delete }.to change(Client, :count).by(-1)
  end

  it 'should find instance by attribute' do
    client
    result = Client.find_by(firstname: 'Marijus')
    expect(result).to include(client)
  end

  it 'should not find instance by attribute using not existing value' do
    result = Client.find_by(firstname: 'PetrasSkaicius')
    expect(result).to be_empty
  end

  it 'should walk through one relation' do
    client
    computer
    expect(computer.client).to eq client
  end

  it 'should walk through many relation' do
    client
    computer
    expect(client.computers).to include(computer)
  end

  context 'when storing state' do
    it 'should save model data to .yml file' do
      filename = 'spec/storage/Client.yml'

      File.delete(filename) if File.exist? filename

      Client.new(
        'Test',
        'Storage',
        '0037061234567',
        'mail@localhost'
      )

      Client.dump

      correct = nil

      File.open(filename + '-correct') do |f|
        correct = f.read
      end

      File.open(filename) do |f|
        expect(correct).to eq f.read
      end
    end

    it 'should load model data from .yml file' do
      Client.new(
        'Test',
        'Storage',
        '0037061234567',
        'mail@localhost'
      )
      Client.dump

      original_instances = Client.instances

      Client.reset
      Client.load

      expect(original_instances).to eq Client.instances
    end
  end

  it 'should remove all instances when performing reset' do
    client
    Client.reset
    expect(Client.instances.size).to eq 0
  end

  it 'should not be equal when comparing different objects' do
    expect(client).not_to eq Client.new('Anas', 'Ponas', '1234', '@here')
  end

  it 'should be equal when comparing the same object' do
    o = client
    expect(o).to eq o
  end
end
