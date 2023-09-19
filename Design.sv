module hamming_code (
    input logic [7:0] data_in,   // Dados de entrada de 8 bits
    output logic [11:0] encoded_data,  // Dados codificados de 16 bits
    output logic [3:0] parity_bits  // Bits de paridade
);

    logic [3:0] parity;

    always_comb begin
        // Calcula os bits de paridade
        parity_bits[0] = data_in[0] ^ data_in[1] ^ data_in[3] ^ data_in[4] ^ data_in[6];
        parity_bits[1] = data_in[0] ^ data_in[2] ^ data_in[3] ^ data_in[5] ^ data_in[6];
        parity_bits[2] = data_in[1] ^ data_in[2] ^ data_in[3] ^ data_in[7];
        parity_bits[3] = data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7];

        // Cria os dados codificados com os bits de paridade
        encoded_data[0] = parity_bits[0];
        encoded_data[1] = parity_bits[1];
        encoded_data[2] = data_in[0];
        encoded_data[3] = parity_bits[2];
        encoded_data[4] = data_in[1];
        encoded_data[5] = data_in[2];
        encoded_data[6] = data_in[3];
        encoded_data[7] = parity_bits[3];
        encoded_data[8] = data_in[4];
        encoded_data[9] = data_in[5];
        encoded_data[10] = data_in[6];
        encoded_data[11] = data_in[7];


    end
	

endmodule




module hamming_decode (
    input logic [11:0] encoded_data,  // Dados codificados de 16 bits
    output logic [7:0] decoded_data,   // Dados decodificados de 8 bits
    output logic [3:0] verify_bit       // Bits de erro detectados
);

	logic [11:0] received_data;

    always_comb begin
        // Calcula os bits de paridade
		received_data = encoded_data;
        verify_bit[0] = received_data[0] ^ received_data[2] ^ received_data[4] ^ received_data[6] ^        received_data[8] ^ received_data[10];
        verify_bit[1] = received_data[1] ^ received_data[2] ^ received_data[5] ^ received_data[6] ^ received_data[9] ^ received_data[10];
        verify_bit[2] = received_data[3] ^ received_data[4] ^ received_data[5] ^ received_data[6] ^ received_data[11];
        verify_bit[3] = received_data[7] ^ received_data[8] ^ received_data[9] ^ received_data[10] ^ received_data[11];

 		   
        // Corrige o bit de erro, se houver um único erro detectado
        if (verify_bit != 4'b0000) begin
          $display("received data antes : %b",received_data);
          received_data[verify_bit-1] = ~received_data[verify_bit-1];
          $display("received data depois : %b",received_data);
        end

        // Decodifica os dados
        decoded_data[0] = received_data[2];
        decoded_data[1] = received_data[4];
        decoded_data[2] = received_data[5];
        decoded_data[3] = received_data[6];
        decoded_data[4] = received_data[8];
        decoded_data[5] = received_data[9];
        decoded_data[6] = received_data[10];
        decoded_data[7] = received_data[11];

    end

endmodule
