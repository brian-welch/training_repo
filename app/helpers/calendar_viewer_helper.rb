module CalendarViewerHelper
  def calendar_viewer(date, &block) # date = Date.today
    CalendarViewer.new(self, date, block).table
  end

  class CalendarViewer < Struct.new(:view, :date, :callback)
    HEADER = %w[M T W T F S S]
    START_DAY = :monday

    delegate :content_tag, to: :view

    def table
      content_tag :table, class: "calendar_viewer_table" do
        header + week_rows
      end
    end

    def header
      content_tag :tr do
        header_row = HEADER.map do |dotw|
          content_tag :th do
            content_tag :div, dotw
          end
        end
        header_row.join.html_safe
      end
    end

    def week_rows
      weeks.map do |week|
        content_tag :tr do
          week.map {|day| day_cell(day)}.join.html_safe
        end
      end.join.html_safe
    end

    def day_cell(day)
      added_class = day.day.even? ? " test" : ""
      content_tag :td, class: day_box_classes(day) do
        content_tag :div, view.capture(day, &callback),
        # if day.day.even?
        #   "test"
        # end
        class: day_content_classes(day) + added_class
      end
    end


    def day_box_classes(day)
      classes = ["day_box"]
      classes << "todays_box" if day == Date.today
      classes << "not_current_month_box" if day.month != date.month
      classes.empty? ? nil : classes.join(" ")
    end

    def day_content_classes(day)
      classes = ["day_content"]
      classes << "todays_content" if day == Date.today
      classes << "not_current_month_content" if day.month != date.month
      classes.empty? ? nil : classes.join(" ")
    end

    def weeks
      first = date.to_date.beginning_of_month.beginning_of_week(START_DAY)
      last = date.to_date.end_of_month.end_of_week(START_DAY)
      (first..last).to_a.in_groups_of(7)
    end

  #end of class
  end
#end of module
end
