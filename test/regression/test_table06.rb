# -*- coding: utf-8 -*-
require 'helper'

class TestRegressionTable06 < Test::Unit::TestCase
  def setup
    setup_dir_var
  end

  def teardown
    File.delete(@xlsx) if File.exist?(@xlsx)
  end

  def test_table06
    @xlsx = 'table06.xlsx'
    workbook  = WriteXLSX.new(@xlsx)
    worksheet = workbook.add_worksheet

    # Set the column width to match the taget worksheet.
    worksheet.set_column('C:H', 10.288)

    # Add the table.
    worksheet.add_table('C3:F13')
    worksheet.add_table('F15:H20')
    worksheet.add_table('C23:D30')

    # Add a link to check rId handling.
    worksheet.write('A1', 'http://perl.com/')
    worksheet.write('C1', 'http://perl.com/')

    # Add comments to check rId handling.
    worksheet.set_comments_author('John')
    worksheet.write_comment('H1', 'Test1')
    worksheet.write_comment('J1', 'Test2')

    # Add drawing to check rId handling.
    worksheet.insert_image('A4', File.join(@test_dir, 'regression', 'images/blue.png'))

    workbook.close
    compare_xlsx_for_regression(File.join(@regression_output, @xlsx), @xlsx)
  end
end
