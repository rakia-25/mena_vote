class Year < ApplicationRecord
  def self.search(query)
    return all.order('name asc') if query.blank?
    build_where_query(all, query).order('name asc')
  end

  def self.build_where_query(all, query)
    queries = all
    queries = queries.where("created_at >=  ?", query[:created_from]) unless query[:created_from]
    queries = queries.where("created_at <=  ?", DateTime.strptime(query[:created_to], "%m/%d/%Y").end_of_day) unless query[:created_to]
    queries
  end
end
