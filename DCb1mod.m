% Define generator polynomials
gen_poly1 = [1 1 1]; % Generator polynomial g1 (binary: 111)
gen_poly2 = [1 1 0 1]; % Generator polynomial g2 (binary: 111)

% Create the trellis structure
trellis_structure = poly2trellis(3, [7 7]); % For g1 = 111, g2 = 111 in octal form


% Define binary input data
binary_input = [0,1,0,0,0,0,1,1,1,0,0,0,0,1,1,0,1,1,1,1,1,1,0,0,0]; % Given input data

% Convolutionally encode the input data
encoded_output = convenc(binary_input, trellis_structure);

% Display the encoded data
disp('Encoded Output:');
disp(encoded_output);

%% State Table Development
disp('State Table:');
state_labels = {'00', '01', '10', '11'};
input_values = [0 1];
next_state_table = cell(4, 2);
output_table = cell(4, 2);


for state_index = 1:length(state_labels)
    for input_index = 1:length(input_values)
        current_state = state_labels{state_index};
        input_value = input_values(input_index);
        
        % Next state calculation
        next_state = [num2str(input_value) current_state(1:2)];
        next_state = next_state(1:2);
        next_state_table{state_index, input_index} = next_state;
        
        % Output calculation
        output_bit1 = mod(input_value + str2double(current_state(1)) + str2double(current_state(2)), 2);
        output_bit2 = mod(input_value + str2double(current_state(1)) + str2double(current_state(2)), 2);
        output_table{state_index, input_index} = [output_bit1 output_bit2];
        
        % Display state table row
        fprintf('Current State: %s, Input: %d, Next State: %s, Output: [%d %d]\n', ...
            current_state, input_value, next_state, output_bit1, output_bit2);
    end
end

%% Trellis Diagram for Encoding
figure;
hold on;
title('Trellis Diagram for Encoding');
xlabel('Time Step');
ylabel('States');
set(gca, 'YTick', 1:length(state_labels), 'YTickLabel', state_labels);

% Plot states at each time step
time_indices = 0:length(binary_input);
number_of_states = length(state_labels);
for time_index = 1:length(time_indices)
    for state_index = 1:number_of_states
        plot(time_index, state_index, 'bo', 'MarkerFaceColor', 'b');
        text(time_index, state_index, state_labels{state_index}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
    end
end

% Plot state transitions for the actual data path
current_state_index = 1; % Initial state is '00'
for time_index = 1:length(binary_input)
    input_value = binary_input(time_index);
    next_state_index = find(strcmp(state_labels, next_state_table{current_state_index, input_value + 1}));
    
    % Plot the transition
    x_coords = [time_index-1 time_index];
    y_coords = [current_state_index next_state_index];
    plot(x_coords, y_coords, 'r-', 'LineWidth', 2); % Use a thicker red line for the actual data path

    quiver(time_index-1, current_state_index, 1, next_state_index - current_state_index, 0, 'MaxHeadSize', 0.5, 'Color', 'r', 'LineWidth', 2);
    
    % Move to the next state
    current_state_index = next_state_index;
end

hold off;

%% Viterbi Decoding
% Decode the received data using Viterbi algorithm
decoded_data = vitdec(encoded_data, trellis, 5, 'trunc', 'hard');

% Display the decoded data
disp('Decoded Data:');
disp(decoded_data);

% Check if the decoded data matches the input data
if isequal(input_data, decoded_data)
    disp('Decoded data matches the original input data.');
else
    disp('Decoded data does NOT match the original input data.');
end

%% Trellis Diagram for Decoding
figure;
hold on;
title('Trellis Diagram for Decoding');
xlabel('Time Step');
ylabel('States');
set(gca, 'YTick', 1:length(states), 'YTickLabel', states);

% Plot states at each time step
for t = 1:length(time_steps)
    for s = 1:num_states
        plot(t, s, 'bo', 'MarkerFaceColor', 'b');
        text(t, s, states{s}, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
    end
end

% Plot state transitions for the actual decoded path
current_state_idx = 1; % Initial state is '00'
for t = 1:length(decoded_data)
    input_bit = decoded_data(t);
    next_state_idx = find(strcmp(states, next_states{current_state_idx, input_bit + 1}));
    
    % Plot the transition
    x = [t-1 t];
    y = [current_state_idx next_state_idx];
    plot(x, y, 'g-', 'LineWidth', 2); % Use a thicker green line for the actual decoded data path
    quiver(t-1, current_state_idx, 1, next_state_idx - current_state_idx, 0, 'MaxHeadSize', 0.5, 'Color', 'g', 'LineWidth', 2);
    
    % Move to the next state
    current_state_idx = next_state_idx;
end
