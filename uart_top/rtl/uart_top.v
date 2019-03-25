module uart_top(
    input           sys_clk,          //外部50M时钟
    input           sys_rst_n,        //外部复位信号，低有效
    //uart接口
    input           uart_rxd,         //UART接收端口
    output          uart_txd  ,        //UART发送端口
	 output 			wire[3:0]  led_en
    );
    
//parameter define
parameter  CLK_FREQ = 50000000;       //定义系统时钟频率
parameter  UART_BPS = 115200;         //定义串口波特率
    
//wire define   
wire       uart_en_w;                 //UART发送使能
wire [7:0] uart_data_w;               //UART发送数据
//wire       clk_1m_w;                  //1MHz时钟，用于Signaltap调试

//*****************************************************
//**                    main code
//*****************************************************
//clk_div u_pll(                        //时钟分频模块，用于调试
 //   .inclk0         (sys_clk),
//    .c0             (clk_1m_w)
//);
     
uart_recv #(                          //串口接收模块
    .CLK_FREQ       (CLK_FREQ),       //设置系统时钟频率
    .UART_BPS       (UART_BPS))       //设置串口接收波特率
u_uart_recv(                 
    .sys_clk        (sys_clk), 
    .sys_rst_n      (sys_rst_n),
    
    .uart_rxd       (uart_rxd),
    .uart_done      (uart_en_w),
    .uart_data      (uart_data_w)
    );
    
uart_send #(                          //串口发送模块
    .CLK_FREQ       (CLK_FREQ),       //设置系统时钟频率
    .UART_BPS       (UART_BPS))       //设置串口发送波特率
u_uart_send(                 
    .sys_clk        (sys_clk),
    .sys_rst_n      (sys_rst_n),
     
    .uart_en        (uart_en_w),
    .uart_din       (uart_data_w),
    .uart_txd       (uart_txd)
    );

led u_led(
	.sys_clk  (sys_clk),
	.sys_rst_n  (sys_rst_n),
	.uart_en   (uart_en_w),
	.led_en		(led_en)


);
endmodule 