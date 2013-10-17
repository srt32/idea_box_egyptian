class User

  attr_reader :email, :id

  def initialize(input)
    @email = input["email"]
    @id = assign_pk
  end

  def assign_pk
    if UserStore.max_id
      return UserStore.max_id + 1
    else
      return 1
    end
  end

end
