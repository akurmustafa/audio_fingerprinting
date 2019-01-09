function [] = update_database()
%   Stores all the songs under the songs folder
%   as audio fingerprint dictionary to the database
    % update database
    songs_struct = dir('songs_in_the_database_formatted');
    songs_cell = struct2cell(songs_struct);
    song_names = songs_cell(1,3:end);
    song_list = string(song_names);
    for i=1:length(song_list)
        song_path = sprintf('songs_in_the_database_formatted/%s', song_list(i));
        add_song_to_database(song_path, i);
    end
end
