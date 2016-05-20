json.array!(@gigs) do |gig|
  json.extract! gig, :id
  json.url gig_url(gig, format: :json)
end
