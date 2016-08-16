require 'spec_helper'

describe Puppet::Type.type(:assert) do
  subject { Puppet::Type.type(:assert).new(:name => 'foo', :path => '/foo') }

  it 'should accept ensure' do
    subject[:ensure] = :present
    expect(subject[:ensure]).to eq :present
  end

  it 'should accept a truthy condition' do
    subject[:condition] = 'foo'
    expect(subject[:condition]).to eq true
  end

  it 'should flag duplicated conditions' do
    expect {
      Puppet::Type.type(:assert).new(:name => 'another foo', :file => '/foo', :command => 'foo')
    }.to raise_error(Puppet::Error, /One only of .* parameters are supported/)
  end
end
