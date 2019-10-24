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

  def admit(new_patron)
    @patrons << new_patron
    exhibits_to_attend
  end
#keep working this..
  # def exhibits_to_attend
  #   @patrons.find_all do |patron|
  #     patron.interests.include?(exhibit.name)
  #   end
  # end

  def recommend_exhibits(patron)
    @exhibits.find_all do |exhibit|
      patron.interests.include?(exhibit.name)
    end
  end

  def patrons_by_exhibit_interest
    @exhibits.reduce({}) do |acc, exhibit|
      patrons_with_interest = @patrons.find_all do |patron|
        patron.interests.include?(exhibit.name)
      end
      acc[exhibit] = patrons_with_interest
      acc
    end
  end
end
