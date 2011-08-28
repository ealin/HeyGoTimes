class CreateSystemDatas < ActiveRecord::Migration
  def self.up
    create_table :system_datas do |t|
        t.datetime :last_system_notice, :default => Time.now
        t.datetime :last_news_rank_reduction, :default => Time.now
    end
  end

  def self.down
    drop_table :system_datas
  end
end
