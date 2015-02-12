#original, newFile = ARGV
#datafile = ARGV.first
	#require 'pry'
	#require 'bye-bug'

	#gem install pry
	#gem install pry bye-bug

class MovieTest

	def initialize
	end

	def mean
	end

	def sttdev
	end

	def rms
	end

	def to_a
	end
end



class MovieData

	attr_reader :ratings, :f, :users   #check what this line is doing
	def initialize
		@ratings = Hash.new
		@f = File.read('u.data')
		@users = Hash.new
	end


	def load_data
		f.each_line do |line|
			words = line.split("\t")
			if !ratings.has_key? words[1]
				ratings.store(words[1], Array.new{Array.new})
			end
			ratings.store(words[1], ratings[words[1]].push(words[0, 2]))
		end
		puts "Load complete."

	end

	def load_users
		f.each_line do |line|
			words = line.split("\t")
			if !users.has_key? words[0]
				users.store(words[0], Array.new{Array.new})
			end
			users.store(words[0], users[words[0]].push(words[1, 2]))
		end
		puts "Load users complete."
	end

#not done yet
	def popularity(movie_id)
		ttlMVRatings = ratings[movie_id].length
		ratio = 1.0 + ttlMVRatings/100000.0
		sum = 0
		@ratings[movie_id].each do |i|
			sum += i[1].to_f
		end
		pops = sum/ttlMVRatings * ratio
		puts pops
	end

	def popularity_list
		list_by_pops = Hash.new
		@ratings.each do |i|
#			list_by_pops.store(i, popularity(i))
		end
	#	puts list_by_pops
		return list_by_pops
	end

	def similarity(user1, user2)
		if user1 != user2
			#I have am comparing the first user's hash with the second user's hash
			#using the movie_id to find the same movies each user watched and gave the same ratings to
			same_exact_movies = @users[user1] & @users[user2]
			user1_likes = @users[user1].sort_by{|x,y| y}.reverse
			user2_likes = @users[user2].sort_by{|x,y| y}.reverse
		#	puts user1_likes.to_s
		#	puts user2_likes.to_S   #this line is causing me errors
		#	user1_hash = @ratings[user1].keys
		#	puts same_exact_movies.to_s
			similar_points = same_exact_movies.length()
		#	puts "#{similar_points}"
		#	puts similar_points
			return similar_points
		else
			return 0
		end
	end

	def most_similar(u)
		similar_users = Hash.new
		user_ids_array = @users.keys
		user_ids_array.each do |user_ids|		#for each user id
			similar_users.store(user_ids, similarity(u, user_ids))	#store the user_id and the similarity
		end
		similarity_table = Array.new
		user_sorted = similar_users.sort_by { |keys, v| v }.reverse	#Sorted hash table by user id as key
		

		user_sorted.each do |user_id|
			similarity_table.push(user_id[0])
		end
		return similarity_table
	end

	def check(u)
		list_sim_to_u = Hash.new 
		
	end

	def rating(u, m)
		index =  @users[u].index(@users[u].detect{|movie| movie.include?(m)})  
		if index	#checking to see if index is nil
			return users[u][index][1]
		else
			puts "enters"
			return 0
		end
	end

	def predict(u, m)
		similar_users = most_similar(u)
		index =  @users[u].index(@users[u].detect{|movie| movie.include?(m)}) 
		similar_users.each do |user|
			if index
				puts users[user][1][1]
				return users[user][1][1]
			end
		end
	end

	def movies(u)
		movies_watched = Array.new
		@users[u].each do |movies|
			movies_watched.push(movies[0])
		end
	end

	def viewers(m)
		user_watched_movie = Array.new
		@ratings[m].each do |movie|
			user_watched_movie.push(movie[0])
		end
		puts user_watched_movie
		puts @ratings
	end

	def run_test(k)
	end

	def quit
		puts "Done with file."
		datafile.close
	end
end

test = MovieData.new()
test.load_data
#test.popularity('50')
#test.popularity_list()
test.load_users
#test.similarity("196", "63")
test.most_similar("196")
test.rating("6", "86")
#test.viewers("86")
test.predict("6", "86")
