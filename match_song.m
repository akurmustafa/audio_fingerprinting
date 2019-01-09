% match songs
clear;
songs_struct = dir('songs_to_match');
songs_cell = struct2cell(songs_struct);
song_names = songs_cell(1,:);
song_list = string(song_names);
song_list = song_list(3:end);
ids = 1:length(song_list);
songs_to_match_dict = containers.Map(ids, song_names(3:end));

songs_struct = dir('songs_in_the_database_formatted');
songs_cell = struct2cell(songs_struct);
song_names = songs_cell(1,:);
song_list = string(song_names);
song_list = song_list(3:end);
ids = 1:length(song_list);
songs_in_the_database_dict = containers.Map(ids, song_names(3:end));

max_common_number = 0;
song_id = 0;
[song_to_match, Fs]=audioread(sprintf('songs_to_match/%s',songs_to_match_dict(36)));
id = 0;
if size(song_to_match, 2) == 2
    song_to_match = (song_to_match(:,1)+song_to_match(:,2))/2;
end
address_of_unknown_song = calc_address(song_to_match, Fs, 0);
number_of_commmon_address = zeros(1, length(song_list));
for i=1:songs_in_the_database_dict.Count
    directory = sprintf('song_hashes/%s.mat', num2str(i, '%04i'));
    current_song = load(directory);
    common_elements = intersect(cell2mat(current_song.M.keys), address_of_unknown_song);
    number_of_commmon_address(i) = length(common_elements);
    if length(common_elements) > max_common_number
        max_common_number = length(common_elements);
        song_id = i;
    end
end
number_of_commmon_address
fprintf('The song is %s \n', songs_in_the_database_dict(song_id));
