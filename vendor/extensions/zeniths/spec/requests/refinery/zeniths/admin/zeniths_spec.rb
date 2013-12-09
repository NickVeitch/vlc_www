# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Zeniths" do
    describe "Admin" do
      describe "zeniths" do
        login_refinery_user

        describe "zeniths list" do
          before do
            FactoryGirl.create(:zenith, :name => "UniqueTitleOne")
            FactoryGirl.create(:zenith, :name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.zeniths_admin_zeniths_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.zeniths_admin_zeniths_path

            click_link "Add New Zenith"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Zeniths::Zenith.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Name can't be blank")
              Refinery::Zeniths::Zenith.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:zenith, :name => "UniqueTitle") }

            it "should fail" do
              visit refinery.zeniths_admin_zeniths_path

              click_link "Add New Zenith"

              fill_in "Name", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Zeniths::Zenith.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:zenith, :name => "A name") }

          it "should succeed" do
            visit refinery.zeniths_admin_zeniths_path

            within ".actions" do
              click_link "Edit this zenith"
            end

            fill_in "Name", :with => "A different name"
            click_button "Save"

            page.should have_content("'A different name' was successfully updated.")
            page.should have_no_content("A name")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:zenith, :name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.zeniths_admin_zeniths_path

            click_link "Remove this zenith forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Zeniths::Zenith.count.should == 0
          end
        end

      end
    end
  end
end
