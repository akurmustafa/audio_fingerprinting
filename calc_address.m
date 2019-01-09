function [address_decimal] = calc_address(song_to_match, Fs, id)
%	Function to calculate address points of a song
%   Detailed explanation goes here
    if size(song_to_match, 2) > 1
        song_to_match_single_channel = (song_to_match(:,1)+song_to_match(:,2))/2;
    else
        song_to_match_single_channel = song_to_match;
    end
    % figure();
    % spectrogram(songShort,'yaxis');
    [s ,w, t]=spectrogram(song_to_match_single_channel,1024,800,1024,Fs,'yaxis');
    num_time_points = size(s, 2);
    num_frequency_points = size(s, 1);
    strongest=zeros(19, num_time_points);
    strongest_frequency_places=zeros(19, num_time_points);
    strongest_time_places=zeros(19, num_time_points);
    bin_limits = ceil(logspace(0, log10(512), 9));
    for i=1:length(t) 
        indice = 1;
        for k=51:25:513
            if k+50 > 513
                [strongest(indice, i), strongest_frequency_places(indice,i)] = max(reshape(abs(s(k-50:end,i)),[1, 514-(k-50)]));
            else
                [strongest(indice, i), strongest_frequency_places(indice,i)] = max(reshape(abs(s(k-50:k+50,i)),[1, 101]));
            end
            strongest_time_places(indice, i) = i;
            strongest_frequency_places(indice, i) = strongest_frequency_places(indice, i) + (k - 50);
            indice = indice + 1;
        end
%         for k = 1:1:512
%             if k < bin_limits(2) && s(k,i) > strongest(1,i)
%                 strongest(1,i)=s(k,i);
%                 strongest_frequency_places(1,i)=k;
%                 strongest_time_places(1,i)=i;
%             end
%             if k >= bin_limits(2) && k < bin_limits(3) && s(k,i) > strongest(2,i)
%                 strongest(2,i) = s(k,i);
%                 strongest_frequency_places(2,i)=k;
%                 strongest_time_places(2,i)=i;
%             end
%             if k >= bin_limits(3) && k < bin_limits(4) && s(k,i) > strongest(3,i)
%                 strongest(3,i)=s(k,i);
%                 strongest_frequency_places(3,i)=k;
%                 strongest_time_places(3,i)=i;
%             end
%             if k >= bin_limits(4) && k < bin_limits(5) && s(k,i)>strongest(4,i)
%                 strongest(4,i)=s(k,i);
%                 strongest_frequency_places(4,i)=k;
%                 strongest_time_places(4,i)=i;
%             end
%             if k >= bin_limits(5) && k < bin_limits(6) && s(k,i)>strongest(5,i)
%                 strongest(5,i)=s(k,i);
%                 strongest_frequency_places(5,i)=k;
%                 strongest_time_places(5,i)=i;
%             end
%             if k >= bin_limits(6) && k < bin_limits(7) && s(k,i)>strongest(6,i)
%                 strongest(6,i)=s(k,i);
%                 strongest_frequency_places(6,i)=k;
%                 strongest_time_places(6,i)=i;
%             end
%             if k >= bin_limits(7) && k < bin_limits(8) && s(k,i)>strongest(7,i)
%                 strongest(7,i) = s(k,i);
%                 strongest_frequency_places(7,i) = k;
%                 strongest_time_places(7,i) = i;
%             end
%             if k >= bin_limits(8) && k < bin_limits(9) && s(k,i)>strongest(8,i)
%                 strongest(8,i) = s(k,i);
%                 strongest_frequency_places(8,i) = k;
%                 strongest_time_places(8,i) = i;
%             end
%         end
    end
    % mean_strongest = sum(strongest,1)./19;    % you can take overall mean also
    mean_strongest = sum(strongest(:))/(19*num_time_points);
    coefficient = 0.7;
    mean_strongest = mean_strongest * coefficient;
    above_mean=(strongest > mean_strongest);
    above_mean_frequency_places = strongest_frequency_places.*(above_mean > zeros(19, num_time_points));
    above_mean_time_places = strongest_time_places.*(above_mean > zeros(19, num_time_points));
    num_peak_point=sum(sum(above_mean));
    target_zone_size = 1;
    bit_num_anchor_frequency = 8;
    bit_num_target_zone_frequency = 8;
    bit_num_delta_time = 10;
    addresses_binary = zeros(num_peak_point, 28, target_zone_size);
    above_mean_time_places_flattened = above_mean_time_places(above_mean_time_places(:)~=0)';
    above_mean_frequency_places_flattened = above_mean_frequency_places(above_mean_frequency_places(:)~=0)';
    addresses_binary(:,1:9,:) = fliplr(de2bi(above_mean_frequency_places_flattened,9));
    addresses_binary(:,10:18,:) = fliplr(de2bi([above_mean_frequency_places_flattened(300:end), zeros(1, 299)],9));
    addresses_binary(:,19:28,:) = fliplr(de2bi([above_mean_time_places_flattened(300:end) - above_mean_time_places_flattened(1:end-299), zeros(1, 299)], 10));
    address_decimal = bi2de(fliplr(reshape(addresses_binary(:),[num_peak_point, 28])));

    couple_binary = zeros(num_peak_point, 24, target_zone_size);
    couple_binary(:,1:16,:) = fliplr(de2bi(above_mean_time_places_flattened, 16));
    couple_binary(:,17:24,:) = fliplr(de2bi(id, 8)).*ones(num_peak_point, 8);
    couple_decimal = bi2de(fliplr(reshape(couple_binary(:),[num_peak_point, 24])));
end
