class AddSlackApiTokenToSlackTrend < ActiveRecord::Migration
  def change
    add_column :slack_trends, :slack_api_token, :string
  end
end
