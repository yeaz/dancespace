# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' },     { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel',     city: cities.first)

roles = Role.create([{ name: 'Choreographer' }, 
                     { name: 'Studio_owner' }])

###### Users / Experiences########

User.create(email: "ellenkim@mail.com", 
            password: "password", 
            password_confirmation: "password", 
            reset_password_token: nil, 
            reset_password_sent_at: nil, 
            remember_created_at: nil, 
            sign_in_count: 1, 
            current_sign_in_at: "2014-06-07 20:25:01", 
            last_sign_in_at: "2014-06-07 20:25:01", 
            current_sign_in_ip: "127.0.0.1", 
            last_sign_in_ip: "127.0.0.1", 
            created_at: "2014-06-07 20:25:01", 
            updated_at: "2014-06-07 20:25:01", 
            first_name: "Ellen", 
            last_name: "Kim", 
            blurb: 'Never forget or regret the past. Live for the present and the future. Create yourself and don\'t EVER let anyone DEFINE you." -Ellen Kim',
            city: "New York",
            state: "NY",
            title: "i love and enjoy everything.",
            fb_url: "https://www.facebook.com/pages/Ellen-Kim/108400459187365",
            twtr_url: "ellenkimchee",
            yt_url: "ellenkimCHEEE", 
            ig_url: "instagram.com/ellenkimchee", 
            website_url: nil, 
            phone_area_code: "", 
            phone_1: "", 
            phone_2: "", 
            photo_path: "/uploads/users/1.jpeg")

Experience.create(content: "Taught master classes with Ian Eastwood", 
                  user_id: 1, 
                  created_at: 0, 
                  updated_at: 0)


Experience.create(content: "Toured with Beyonce, Amerie, LL Cool J, Snoop Dogg, and STOMP",
                  user_id: 1,
                  created_at: 0, 
                  updated_at: 0)

Experience.create(content: "Choreographed for up-and-coming musical artist, Maxine",
                  user_id: 1,
                  created_at: 0, 
                  updated_at: 0)



User.create(email: "emmaportner@mail.com", 
            password: "password", 
            password_confirmation: "password", 
            reset_password_token: nil, 
            reset_password_sent_at: nil, 
            remember_created_at: nil, 
            sign_in_count: 1, 
            current_sign_in_at: "2014-06-07 20:25:01", 
            last_sign_in_at: "2014-06-07 20:25:01", 
            current_sign_in_ip: "127.0.0.1", 
            last_sign_in_ip: "127.0.0.1", 
            created_at: "2014-06-07 20:25:01", 
            updated_at: "2014-06-07 20:25:01", 
            first_name: "Emma", 
            last_name: "Portner", 
            blurb: "I trained at the Canterbury School and am now at the Alley School in NYC. Have my hands full with gigs at the moment.",
            city: "New York",
            state: "NY",
            title: "Dancer and dance photographer",
            fb_url: "https://www.facebook.com/pages/Emma-Portner-Photography/220857377931086",
            twtr_url: "EmmaPortner", 
            yt_url: "EmmaPortner", 
            ig_url: "", 
            website_url: "emmaportnerphotography.tumblr.com",
            phone_area_code: "", 
            phone_1: "", 
            phone_2: "", 
            photo_path: "/uploads/users/2.jpeg")


Experience.create(content: "Toured California to perform Leaves, my first full-length production", 
                  user_id: 2, 
                  created_at: 0, 
                  updated_at: 0)

Experience.create(content: "Assists with contemporary at Broadway Dance Center",
                  user_id: 2, 
                  created_at: 0, 
                  updated_at: 0)


User.create(email: "ianeastwood@mail.com", 
            password: "password", 
            password_confirmation: "password", 
            reset_password_token: nil, 
            reset_password_sent_at: nil, 
            remember_created_at: nil, 
            sign_in_count: 1, 
            current_sign_in_at: "2014-06-07 20:25:01", 
            last_sign_in_at: "2014-06-07 20:25:01", 
            current_sign_in_ip: "127.0.0.1", 
            last_sign_in_ip: "127.0.0.1", 
            created_at: "2014-06-07 20:25:01", 
            updated_at: "2014-06-07 20:25:01", 
            first_name: "Ian", 
            last_name: "Eastwood", 
            blurb: "21 Year old dancer/choreographer getting as much out of life as humanly possible.",
            city: "Chicago",
            state: "IL",
            title: "Professional Dreamer Chaser. Choreographer/Dancer",
            fb_url: "",
            twtr_url: "Ian_Eastwood", 
            yt_url: "DJIcon", 
            ig_url: "instagram.com/ian_eastwood",
            website_url: nil, 
            phone_area_code: "395", 
            phone_1: "224", 
            phone_2: "648", 
            photo_path: "/uploads/users/3.jpeg")

Experience.create(content: "Taught master classes with Ellen Kim",
                  user_id: 3, 
                  created_at: 0, 
                  updated_at: 0)


Experience.create(content: "Worked as choreographer and dancer on DanceOn's Dance Showdown and MTV's Return of the Superstars",
                  user_id: 3, 
                  created_at: 0, 
                  updated_at: 0)

Experience.create(content: "Featured dancer in Justin Bieber's Beauty and the Beat",
                  user_id: 3, 
                  created_at: 0, 
                  updated_at: 0)


User.create(email: "miamichaels@mail.com", 
            password: "password", 
            password_confirmation: "password", 
            reset_password_token: nil, 
            reset_password_sent_at: nil, 
            remember_created_at: nil, 
            sign_in_count: 1, 
            current_sign_in_at: "2014-06-07 20:25:01", 
            last_sign_in_at: "2014-06-07 20:25:01", 
            current_sign_in_ip: "127.0.0.1", 
            last_sign_in_ip: "127.0.0.1", 
            created_at: "2014-06-07 20:25:01", 
            updated_at: "2014-06-07 20:25:01", 
            first_name: "Mia", 
            last_name: "Michaels", 
            blurb: "SYTYCD, Emmy Award winning choreographer",
            city: "Los Angeles",
            state: "CA",
            title: "Director/Choreographer/Los Angeles/SYTYCD",
            fb_url: "",
            twtr_url: "MMRAW", 
            yt_url: "miamichaelsmedia",
            ig_url: "", 
            website_url: "https://en.wikipedia.org/wiki/Mia_Michaels",
            phone_area_code: "310", 
            phone_1: "923", 
            phone_2: "4762", 
            photo_path: "/uploads/users/4.jpeg")

Experience.create(content: "Judged and choreographed on So You Think You Can Dance",
                  user_id: 4, 
                  created_at: 0, 
                  updated_at: 0)



Experience.create(content: "Worked with musical artists Prince, Celine Dion, Madonna, etc",
                  user_id: 4, 
                  created_at: 0, 
                  updated_at: 0)

Experience.create(content: "Choreographed Cirque du Soleil's world tour \"Delirium\"",
                  user_id: 4, 
                  created_at: 0, 
                  updated_at: 0)




User.create(email: "dimoonzhang@mail.com", 
            password: "password", 
            password_confirmation: "password", 
            reset_password_token: nil, 
            reset_password_sent_at: nil, 
            remember_created_at: nil, 
            sign_in_count: 1, 
            current_sign_in_at: "2014-06-07 20:25:01", 
            last_sign_in_at: "2014-06-07 20:25:01", 
            current_sign_in_ip: "127.0.0.1", 
            last_sign_in_ip: "127.0.0.1", 
            created_at: "2014-06-07 20:25:01", 
            updated_at: "2014-06-07 20:25:01", 
            first_name: "Di Moon", 
            last_name: "Zhang", 
            blurb: "IaMmE is auditioning! We're looking for the best hip hop talent to join our crew.",
            city: "San Francisco",
            state: "CA",
            title: "Head Choreographer of IaMmE Crew from Winner America's Best Dance Crew S6",
            fb_url: "facebook.com/pages/DMZ-entertainment/191182427591697", 
            twtr_url: "marvelousmoon", 
            yt_url: "marvelousmoon", 
            ig_url: "instagram.com/dimoonzhang", 
            website_url: "dimoonzhang.com",
            phone_area_code: "", 
            phone_1: "", 
            phone_2: "", 
            photo_path: "/uploads/users/5.jpeg")

Experience.create(content: "Created Marvelous Motion which one 3rd place at the World of Dance competition in Pomona, CA",
                  user_id: 5, 
                  created_at: 0, 
                  updated_at: 0)

Experience.create(content: "Danced with the world famous Tamme Crew",
                  user_id: 5, 
                  created_at: 0, 
                  updated_at: 0)




User.create(email: "brandondumlao@mail.com", 
            password: "password", 
            password_confirmation: "password", 
            reset_password_token: nil, 
            reset_password_sent_at: nil, 
            remember_created_at: nil, 
            sign_in_count: 1, 
            current_sign_in_at: "2014-06-07 20:25:01", 
            last_sign_in_at: "2014-06-07 20:25:01", 
            current_sign_in_ip: "127.0.0.1", 
            last_sign_in_ip: "127.0.0.1", 
            created_at: "2014-06-07 20:25:01", 
            updated_at: "2014-06-07 20:25:01", 
            first_name: "Brandon", 
            last_name: "Dumlao", 
            blurb: "Looking for my next gig in the Los Angeles area",
            city: "North Hollywood",
            state: "CA",
            title: "Dancer/Choreographer from Bay to LA!",
            
            fb_url: "",
            twtr_url: "brandondumlao", 
            yt_url: "brandondumlao87", 
            ig_url: "instagram.com/brandondumlao", 
            website_url: "http://resumes.actorsaccess.com/brandondumlao ",
            phone_area_code: "", 
            phone_1: "", 
            phone_2: "", 
            photo_path: "/uploads/users/6.jpeg")

Experience.create(content: "Part of the top 20 for So You Think You Can Dance, season 6",
                  user_id: 6,
                  created_at: 0, 
                  updated_at: 0)



User.create(email: "sorahyang@mail.com", 
            password: "password", 
            password_confirmation: "password", 
            reset_password_token: nil, 
            reset_password_sent_at: nil, 
            remember_created_at: nil, 
            sign_in_count: 1, 
            current_sign_in_at: "2014-06-07 20:25:01", 
            last_sign_in_at: "2014-06-07 20:25:01", 
            current_sign_in_ip: "127.0.0.1", 
            last_sign_in_ip: "127.0.0.1", 
            created_at: "2014-06-07 20:25:01", 
            updated_at: "2014-06-07 20:25:01", 
            first_name: "Sorah",
            last_name: "Yang",
            blurb: "I dance, I sing, I teach, and I strive to spread empowerment and positivity through all that I do. :) B.S. Business Administration from USC",
            city: "Los Angeles",
            state: "CA",
            title: "Contemporary and hip hop dancer and choreographer",
            fb_url: "",
            twtr_url: "sorahyang",
            yt_url: "sorahyang",
            ig_url: "instagram.com/sorahyang",
            website_url: "sorah-yang.tumblr.com",
            phone_area_code: "", 
            phone_1: "", 
            phone_2: "", 
            photo_path: "/uploads/users/7.jpeg")

Experience.create(content: "Dancer/choreographer with reDEFINE, a professional youth urban dance company",
                  user_id: 7,
                  created_at: 0, 
                  updated_at: 0)

User.create(email: "anthonylee@mail.com", 
            password: "password", 
            password_confirmation: "password", 
            reset_password_token: nil, 
            reset_password_sent_at: nil, 
            remember_created_at: nil, 
            sign_in_count: 1, 
            current_sign_in_at: "2014-06-07 20:25:01", 
            last_sign_in_at: "2014-06-07 20:25:01", 
            current_sign_in_ip: "127.0.0.1", 
            last_sign_in_ip: "127.0.0.1", 
            created_at: "2014-06-07 20:25:01", 
            updated_at: "2014-06-07 20:25:01", 
            first_name: "Anthony",
            last_name: "Lee",
            blurb: "Kinjaz, Culture Shock LA , Frenemies, The LXD, CADC",
            city: nil, 
            state: nil, 
            title: "Contemporary and hip hop dancer and choreographer",
            fb_url: "https://www.facebook.com/antoniousness",
            twtr_url: "_AnthonyLee_",
            yt_url: "anflowny",
            ig_url: "instagram.com/_AnthonyLee_",
            website_url: nil, 
            phone_area_code: "", 
            phone_1: "", 
            phone_2: "", 
            photo_path: "/uploads/users/8.jpeg")

Experience.create(content: "Co-founded Kinjaz, a performance studio that combines music and urban dancing as a form of storytelling.",
                  user_id: 8,
                  created_at: 0, 
                  updated_at: 0)

Experience.create(content: "Worked with Culture Shock Los Angeles, a nonprofit community outreach dance organization",
                  user_id: 8,
                  created_at: 0, 
                  updated_at: 0)


#### Experiencelinks ####

Experiencelink.create(
                      collab_id: 3,
                      collab_type: "user",
                      experience_id: 1,
                      created_at: 0,
                      updated_at: 0,
                      collab_name: "")

Experiencelink.create(
                      collab_id: 1,
                      collab_type: "studio",
                      experience_id: 5,
                      created_at: 0,
                      updated_at: 0,
                      collab_name: "")

Experiencelink.create(
                      collab_id: 1,
                      collab_type: "user",
                      experience_id: 6,
                      created_at: 0,
                      updated_at: 0,
                      collab_name: "")

Experiencelink.create(
                      collab_id: 6,
                      collab_type: "user",
                      experience_id: 9,
                      created_at: 0,
                      updated_at: 0,
                      collab_name: "")
Experiencelink.create(
                      collab_id: 4,
                      collab_type: "user",
                      experience_id: 14,
                      created_at: 0,
                      updated_at: 0,
                      collab_name: "")

########## Studios and Memberships #######################

Studio.create(name: 'Broadway Dance Center', 
              description: "Offers beginning to advanced classes of all ages in ballet, jazz, tap, modern, theater, hip hop, and more.",
              created_at: 0, 
              updated_at: 0, 
              website_url: "broadwaydancecenter.com",
              fb_url: "https://www.facebook.com/broadwaydancecenter",
              yt_username: "broadwaydancecentre",
              twtr_username: "BroadwayDance", 
              ig_url: "instagram.com/dancersunitenc", 
              email: "info@broadwaydancecenter.com",
              phone_area_code: "123", 
              phone_1: "555", 
              phone_2: "9876", 
              lat: 40.759,
              lng: -73.985,
              is_location_set: 1, 
              address_line1: "322 W 45th St #3",
              address_line2: "", 
              city: "New York",
              state: "NY",
              zip_code: "10036",
              photo_path: "/uploads/studios/1.jpeg")

Membership.create(member_id: 1, studio_id: 1, is_admin: true, created_at: 0, updated_at: 0)

Studio.create(name: 'Kinjaz', 
              description: "New York based entertainment company that uniquely combines music, theatre, and urban dancing to create an original form of storytelling",
              created_at: 0, 
              updated_at: 0, 
              website_url: "",
              fb_url: "https://www.facebook.com/kinjaz",
              yt_username: "thekinjaz",
              twtr_username: "KINJAZ",
              ig_url: "instagram.com/_AnthonyLee_",
              email: "info@kinjaz.com",
              phone_area_code: "592", 
              phone_1: "555", 
              phone_2: "9876", 
              lat: 40.806,
              lng: -73.9474,
              is_location_set: 1, 
              address_line1: "114 W 123rd St",
              address_line2: "", 
              city: "New York",
              state: "NY",
              zip_code: "10027",
              photo_path: "/uploads/studios/2.jpeg")

Membership.create(member_id: 8, studio_id: 2, is_admin: true, created_at: 0, updated_at: 0)

Studio.create(name: "Millennium Dance Complex",
              description: "Premiere studio of the commercial dance world catering to the artistic community of the greater LA area and the world!",
              created_at: 0, 
              updated_at: 0, 
              website_url: "http://millenniumdancecomplex.com/",
              fb_url: "https://www.facebook.com/dancemillennium",
              yt_username: "davidmooretv",
              twtr_username: "DanceMillennium",
              ig_url: "instagram.com/famedancestudio",
              email: "info@millennium.com",
              phone_area_code: "310", 
              phone_1: "515", 
              phone_2: "9276", 
              lat: 34.1636,
              lng: -118.374,
              is_location_set: 1, 
              address_line1: "5113 Lankershim Blvd",
              address_line2: "", 
              city: "San Fernando Valley",
              state: "CA",
              zip_code: "91601",
              photo_path: "/uploads/studios/3.jpeg")

Membership.create(member_id: 4, studio_id: 3, is_admin: true, created_at: 0, updated_at: 0)

########### TAGS ############

tags = ["contemporary", "jazz", "ballet", "hip hop", "modern", "salsa", "swing", "tap"]

for tag in tags
  ActsAsTaggableOn::Tag.create(
                               name: tag,
                               taggings_count: 5)
end

ActsAsTaggableOn::Tagging.create(
                                 tag_id: 1,
                                 taggable_id: 1,
                                 context: 'styles',
                                 taggable_type: 'User',
                                 created_at: 0)
ActsAsTaggableOn::Tagging.create(
                                 tag_id: 1,
                                 taggable_id: 2,
                                 context: 'styles',
                                 taggable_type: 'User',
                                 created_at: 0)
ActsAsTaggableOn::Tagging.create(
                                 tag_id: 1,
                                 taggable_id: 3,
                                 context: 'styles',
                                 taggable_type: 'User',
                                 created_at: 0)

ActsAsTaggableOn::Tagging.create(
                                 tag_id: 1,
                                 taggable_id: 4,
                                 context: 'styles',
                                 taggable_type: 'User',
                                 created_at: 0)

ActsAsTaggableOn::Tagging.create(
                                 tag_id: 1,
                                 taggable_id: 5,
                                 context: 'styles',
                                 taggable_type: 'User',
                                 created_at: 0)

ActsAsTaggableOn::Tagging.create(
                                 tag_id: 2,
                                 taggable_id: 6,
                                 context: 'styles',
                                 taggable_type: 'User',
                                 created_at: 0)

ActsAsTaggableOn::Tagging.create(
                                 tag_id: 2,
                                 taggable_id: 7,
                                 context: 'styles',
                                 taggable_type: 'User',
                                 created_at: 0)

ActsAsTaggableOn::Tagging.create(
                                 tag_id: 2,
                                 taggable_id: 8,
                                 context: 'styles',
                                 taggable_type: 'User',
                                 created_at: 0)

ActsAsTaggableOn::Tagging.create(
                                 tag_id: 2,
                                 taggable_id: 1,
                                 context: 'styles',
                                 taggable_type: 'User',
                                 created_at: 0)

ActsAsTaggableOn::Tagging.create(
                                 tag_id: 2,
                                 taggable_id: 2,
                                 context: 'styles',
                                 taggable_type: 'User',
                                 created_at: 0)

ActsAsTaggableOn::Tagging.create(
                                 tag_id: 3,
                                 taggable_id: 3,
                                 context: 'styles',
                                 taggable_type: 'User',
                                 created_at: 0)

ActsAsTaggableOn::Tagging.create(
                                 tag_id: 3
                                 taggable_id: 4,
                                 context: 'styles',
                                 taggable_type: 'User',
                                 created_at: 0)

ActsAsTaggableOn::Tagging.create(
                                 tag_id: 3,
                                 taggable_id: 5,
                                 context: 'styles',
                                 taggable_type: 'User',
                                 created_at: 0)

ActsAsTaggableOn::Tagging.create(
                                 tag_id: 3,
                                 taggable_id: 6,
                                 context: 'styles',
                                 taggable_type: 'User',
                                 created_at: 0)

# ActsAsTaggableOn::Tagging.create(
#                                  tag_id: 3,
#                                  taggable_id: 7,
#                                  context: 'styles',
#                                  taggable_type: 'User',
#                                  created_at: 0)

# ActsAsTaggableOn::Tagging.create(
#                                  tag_id: 3,
#                                  taggable_id: 8,
#                                  context: 'styles',
#                                  taggable_type: 'User',
#                                  created_at: 0)

# ActsAsTaggableOn::Tagging.create(
#                                  tag_id: 3,
#                                  taggable_id: 8,
#                                  context: 'styles',
#                                  taggable_type: 'User',
#                                  created_at: 0)

# ActsAsTaggableOn::Tagging.create(
#                                  tag_id: 3,
#                                  taggable_id: 8,
#                                  context: 'styles',
#                                  taggable_type: 'User',
#                                  created_at: 0)






