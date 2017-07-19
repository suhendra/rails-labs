module Types
  QueryType = GraphQL::ObjectType.define do
    name "Query"
    description "The query root for this schema"

    field :allPosts, !types[Types::PostType] do
      description "fetch all posts"
      resolve -> (o, args, c) { Post.all }

    # You can define fields on the fly:
    field :hero do
      type !CharacterInterface
      description "The hero of the saga"

      argument :episode, EpisodeEnum, "If provided, return the hero of that episode"

      resolve -> (obj, args, ctx) do
        args["episode"] == 5 ? Human.find(1000) : Droid.find(2001)
      end
    end

    field :human, HumanType, field: Fields::FetchField.build(type: HumanType, model: Human)
    field :droid, DroidType, field: Fields::FetchField.build(type: DroidType, model: Droid)
    field :node, GraphQL::Relay::Node.field
  end
end
