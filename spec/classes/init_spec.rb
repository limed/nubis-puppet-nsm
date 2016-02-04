require 'spec_helper'
describe 'nsm' do

  context 'with defaults for all parameters' do
    it { should contain_class('nsm') }
  end
end
