module Trade::Searchable
  extend ActiveSupport::Concern

  included do

    scope :search_by_user, lambda { |user_id|
      return if user_id.blank?
      where("trades.user_id" => user_id)
    }

    scope :search_by_trade_category, lambda { |trade_category_id|
      return if trade_category_id.blank?
      where("trades.trade_category_id" => trade_category_id)
    }

    scope :search_by_trade_style, lambda { |trade_style_id|
      return if trade_style_id.blank?
      where("trades.trade_style_id" => trade_style_id)
    }

    scope :search_by_min_pips, lambda { |min_pips|
      return if min_pips.blank?
      result_trade_ids = Trade.ids.select do |trade_id|
        Trade.find(trade_id).pips >= min_pips.to_i
      end
      where(id: result_trade_ids)
    }

    scope :search_by_max_pips, lambda { |max_pips|
      return if max_pips.blank?
      result_trade_ids = Trade.ids.select do |trade_id|
        Trade.find(trade_id).pips <= max_pips.to_i
      end
      where(id: result_trade_ids)
    }

    scope :search_by_uppere_entry_time, lambda { |min_entry_time|
      return if min_entry_time.blank?
      where(arel_table[:entry_time].gteq(min_entry_time))
    }

    scope :search_by_lower_entry_time, lambda { |max_entry_time|
      return if max_entry_time.blank?
      where(arel_table[:entry_time].lteq(max_entry_time))
    }

    scope :search_by_uppere_exit_time, lambda { |min_exit_time|
      return if min_exit_time.blank?
      where(arel_table[:exit_time].gteq(min_exit_time))
    }

    scope :search_by_lower_exit_time, lambda { |max_exit_time|
      return if max_exit_time.blank?
      where(arel_table[:exit_time].lteq(max_exit_time))
    }

    scope :search_by_result, lambda { |result|
      return if result.blank?
      where("trades.result" => result)
    }
    
  end
end