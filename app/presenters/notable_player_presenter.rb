class NotablePlayerPresenter < HistoryPresenter
    def category_name
        "162 Game Players"
    end
    def self.wrap(h)
        NotablePlayerPresenter.new(h)
    end
    def table_headers
        [ "Player", "Date" ]
    end
    def display_fields
        [ :data, :finish ]
    end
    def formatted_date
        date.strftime("%-m/%-d/%Y")
    end
    delegate :name, :date, to: :history
end
