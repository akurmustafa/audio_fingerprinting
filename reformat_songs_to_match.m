clear;
songs_struct = dir('songs_in_the_database_formatted');
songs_cell = struct2cell(songs_struct);
song_names = songs_cell(1,:);
song_list = string(song_names);
song_list = song_list(3:end);
ids = 1:length(song_list);
songs_in_the_database_dict = containers.Map(ids, song_names(3:end));
for i=1:songs_in_the_database_dict.Count
   songs_in_the_database_dict(i);
   [song_original, Fs]=audioread(sprintf('songs_in_the_database_formatted/%s',songs_in_the_database_dict(i))); 
   for copy=1:2
       if size(song_original, 1)> Fs*65
           start_point =randi([5 45]);
           song_formatted = song_original(start_point*Fs:(start_point+ 20)*Fs,:);
       elseif size(song_original, 1)> Fs*35
           start_point =randi([5 15]);
           song_formatted = song_original(start_point*Fs:(start_point+ 20)*Fs,:);
       else
           start_point =randi([3 12]);
           song_formatted = song_original(start_point*Fs:(start_point+ 20)*Fs,:);
       end
       cur_song_name = songs_in_the_database_dict(i);
       if cur_song_name(end-2:end)~='wav'
           cur_song_name(end-2:end)='wav';
       end
       audiowrite(sprintf('songs_to_match/%s_rand_%s.wav',cur_song_name(1:end-4), num2str(copy)), song_formatted, Fs);
   end
   audiowrite(sprintf('songs_to_match/%s.wav',cur_song_name(1:end-4)), song_original, Fs);
end