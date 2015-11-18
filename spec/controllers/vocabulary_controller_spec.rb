# Copyright 2011-2015, The Trustees of Indiana University and Northwestern
#   University.  Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
# 
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software distributed 
#   under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
#   CONDITIONS OF ANY KIND, either express or implied. See the License for the 
#   specific language governing permissions and limitations under the License.
# ---  END LICENSE_HEADER BLOCK  ---

require 'spec_helper'

describe VocabularyController, type: :controller do
  render_views

  before(:each) { Avalon::ControlledVocabulary.class_variable_set :@@path, Rails.root.join('spec/fixtures/controlled_vocabulary.yml') }

  describe "#show" do
    it "should return vocabulary for entire app" do
      get 'index'
      expect(JSON.parse(response.body)).to include('units','note_types','identifier_types')
    end
    it "should return a particular vocabulary" do
      get 'index', vocabulary: :units
      expect(JSON.parse(response.body)).to include('Default Unit')
    end
  end

  describe "#add" do
    it "should add unit to controlled vocabulary" do
      post 'add_entry', vocabulary: :units, entry: 'New Unit'
      expect(Avalon::ControlledVocabulary.vocabulary[:units]).to include("New Unit")
    end
  end
end
