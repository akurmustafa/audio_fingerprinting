clear;
songs_struct = dir('songs_in_the_database');
songs_cell = struct2cell(songs_struct);
song_names = songs_cell(1,:);
song_list = string(song_names);
song_list = song_list(3:end);
ids = 1:length(song_list);
songs_in_the_database_dict = containers.Map(ids, song_names(3:end));
for i=1:songs_in_the_database_dict.Count
   songs_in_the_database_dict(i);
   [song_original, Fs]=audioread(sprintf('songs_in_the_database/%s',songs_in_the_database_dict(i))); 
   if size(song_original, 1)> Fs*65
       song_formatted = song_original(5*Fs:65*Fs,:);
   else
       song_formatted = song_original(5*Fs:end,:);
   end
   cur_song_name = songs_in_the_database_dict(i);
   if cur_song_name(end-2:end)=='mp3'
       cur_song_name(end-2:end)='wav';
   end
   audiowrite(sprintf('songs_in_the_database_formatted/%s',cur_song_name), song_formatted, Fs);
end