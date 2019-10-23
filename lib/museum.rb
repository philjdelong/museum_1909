class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(new_exhibit)
    @exhibits << new_exhibit
  end

  def add_patron(new_patron)
    @patrons << new_patron
  end

  def recommend_exhibits(patron)
    rec_exhibs = @exhibits.find_all do |exhibit|
      if patron.interests.include?(exhibit.name)
        exhibit
      end
    end
    rec_exhibs
  end

end
