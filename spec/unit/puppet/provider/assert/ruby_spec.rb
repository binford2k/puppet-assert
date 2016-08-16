require 'spec_helper'

describe 'Ruby provider for assert' do
  context 'when validating a file' do
    let(:resource) { Puppet::Type.type(:assert).new(:name => 'foo', :file => '/foo') }
    subject { Puppet::Type.type(:assert).provider(:ruby).new(resource) }

    it 'exists? returns true if file exists' do
      File.expects(:file?).with('/foo').returns(true)
      expect(subject.exists?).to eq true
    end

    it 'exists? returns false if file does not exist' do
      File.expects(:file?).with('/foo').returns(false)
      expect(subject.exists?).to eq false
    end
  end

   context 'when validating a directory' do
    let(:resource) { Puppet::Type.type(:assert).new(:name => 'foo', :directory => '/foo') }
    subject { Puppet::Type.type(:assert).provider(:ruby).new(resource) }

    it 'exists? returns true if directory exists' do
      File.expects(:directory?).with('/foo').returns(true)
      expect(subject.exists?).to eq true
    end

    it 'exists? returns false if directory does not exist' do
      File.expects(:directory?).with('/foo').returns(false)
      expect(subject.exists?).to eq false
    end
  end

   context 'when validating a path' do
    let(:resource) { Puppet::Type.type(:assert).new(:name => 'foo', :path => '/foo') }
    subject { Puppet::Type.type(:assert).provider(:ruby).new(resource) }

    it 'exists? returns true if path exists' do
      File.expects(:exist?).with('/foo').returns(true)
      expect(subject.exists?).to eq true
    end

    it 'exists? returns false if path does not exist' do
      File.expects(:exist?).with('/foo').returns(false)
      expect(subject.exists?).to eq false
    end
  end

   context 'when validating a command' do
    let(:resource) { Puppet::Type.type(:assert).new(:name => 'foo', :command => 'foo') }
    subject { Puppet::Type.type(:assert).provider(:ruby).new(resource) }

    it 'exists? returns true if command succeeds' do
      subject.expects(:system).with('foo').returns(true)
      expect(subject.exists?).to eq true
    end

    it 'exists? returns true if command fails' do
      subject.expects(:system).with('foo').returns(false)
      expect(subject.exists?).to eq false
    end
  end

  context 'when validating a condition' do
    it 'should succeed when passed a true condition' do
      resource = Puppet::Type.type(:assert).new(:name => 'foo', :condition => true)
      subject  = Puppet::Type.type(:assert).provider(:ruby).new(resource)

      expect(subject.exists?).to eq true
    end

    it 'should succeed when passed a truthy condition' do
      resource = Puppet::Type.type(:assert).new(:name => 'foo', :condition => 'a truthy string')
      subject  = Puppet::Type.type(:assert).provider(:ruby).new(resource)

      expect(subject.exists?).to eq true
    end

    it 'should succeed when passed a false condition' do
      resource = Puppet::Type.type(:assert).new(:name => 'foo', :condition => false)
      subject  = Puppet::Type.type(:assert).provider(:ruby).new(resource)

      expect(subject.exists?).to eq false
    end
  end

  context 'when validating assertions' do
    let(:resource) { Puppet::Type.type(:assert).new(:name => 'foo', :file => '/foo') }
    subject { Puppet::Type.type(:assert).provider(:ruby).new(resource) }

    it 'should fail validation if the assertion fails' do
      expect {
        subject.create
      }.to raise_error(Puppet::Error, /^Assert Failed:/)
    end

    it 'should fail validation if the assertion negatively fails' do
      expect {
        subject.destroy
      }.to raise_error(Puppet::Error, /^Assert Failed:/)
    end
  end
end
