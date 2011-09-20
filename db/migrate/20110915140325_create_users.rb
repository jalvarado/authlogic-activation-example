class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :phone_number

      # Authlogic required DB columns
      #t.string    :login,               :null => false                # optional, you can use email instead, or both
      t.string    :email,               :null => false                # optional, you can use login instead, or both
      t.string    :crypted_password#,    :null => false                # optional, see below
      t.string    :password_salt#,       :null => false                # optional, but highly recommended
      t.string    :persistence_token#,   :null => false                # required
      t.string    :single_access_token#, :null => false                # optional, see Authlogic::Session::Params
      t.string    :perishable_token#,    :null => false                # optional, see Authlogic::Session::Perishability

      # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
      t.integer   :login_count,         :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.integer   :failed_login_count,  :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_request_at                                    # optional, see Authlogic::Session::MagicColumns
      t.datetime  :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
      t.string    :current_login_ip                                   # optional, see Authlogic::Session::MagicColumns
      t.string    :last_login_ip                                      # optional, see Authlogic::Session::MagicColumns

      # Magic states. ActiveRecord will automatically create ? methods for these boolean fields.
      # Authlogic will detect these ? methods and will automatically use them in the login process.
      t.boolean  :active,              :null => false, :default => false
      #t.boolean  :approved             :null => false, :default => false
      #t.boolean  :confirmed            :null => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
