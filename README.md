# MultiMedia_Lab1

##### 18307130251 蒋晓雯

###### （包括：1.对代码的简单说明；2.阐述使用非均匀量化的优点）

###### 以[学号+姓名]命名打包zip，如：18202010001张三.zip

## 代码简单说明

### 均匀量化

在整个量化范围`(-1, 1)`内，且量化间隔都相等
$$
\triangle = \frac {(1-(-1))}{n} = \frac {2}{n}
$$

<center><strong>量化间隔</strong></center>

<img src="images\均匀量化.png" alt="均匀量化" style="zoom: 67%;" />

<center><strong>图1 - 8个量化级的均匀量化示意图</strong></center>

#### `u_pcm`

```matlab
function [a_quan]=u_pcm(a,n)
	# a is input
	# n is quantization levels
	# a_quan is quantized output before encoding
	
    up_bound = 1; %上界
    bottom_bound = -1; %下界
    arrange = up_bound - bottom_bound; %范围
    delta = arrange / n; % 量化间隔，每一个都一样
    % 对输入取正向化后的量化输出等级，向上取整，需要再减去0.5个delta
    a_quan = ceil(abs(a) / delta) * delta - 0.5 * delta;
    % 把输入的符号乘回去
    a_quan = a_quan .* sign(a);

end
```

### 非均匀量化

#### `ula_pcm`

```matlab
function [a_quan]=ula_pcm(a,n,u)
%ULA_PCM 	u-law PCM encoding of a sequence
%       	[A_QUAN]=MULA_PCM(X,N,U).
%       	X=input sequence.
%       	n=number of quantization levels (even).     	
%		a_quan=quantized output before encoding.
%       U the parameter of the u-law

    a_quan = ulaw(abs(a), u); % 对正向化后的输入进行u率非线性放大
    a_quan = u_pcm(a_quan, n); % 对非线性变换的结果进行均匀量化
    % 把均匀量化的结果通过u率的反函数变换回输入的量化结果，并把符号还给它
    a_quan = inv_ulaw(a_quan, u) .* sign(a); 
    
end
```

$$
y=\frac{\ln(1 + \mu|x|)}{\ln(1+\mu)}sign(x)
$$

<center><strong>u率公式</strong></center>

#### `ulaw`

```matlab
function [z]=ulaw(y,u)
%		u-law nonlinearity for nonuniform PCM
%		X=ULAW(Y,U).
%		Y=input vector.

    % u率公式
    z = (log(1 + u * y) / log(1 + u));

end
```

$$
x=\frac{\left( 1+\mu \right) ^y-1}{\mu}
$$

<center><strong>u率反函数公式</strong></center>

#### `inv_ulaw`

```matlab
function x=inv_ulaw(y,u)
%INV_ULAW		the inverse of u-law nonlinearity
%X=INV_ULAW(Y,U)	X=normalized output of the u-law nonlinearity.

	% u率反函数公式
    m = (1 + u) .^ y;
    x = (m - 1) / u;
    
end
```

## 非均匀量化的优点

非均匀量化对于小信号量化间隔小，对于大信号量化间隔大，在处理小信号时，可以得到较好的量化信噪比。
$$
\frac{dy}{dx}|_{x\rightarrow 0}=\frac{\mu}{\left( 1+\mu x \right) \ln \left( 1+\mu \right)}|_{x\rightarrow 0}=\frac{\mu}{\ln \left( 1+\mu \right)}>1
$$

$$
Q=10\log \left( \frac{dy}{dx} \right) >0
$$

<center><strong>公式推导说明</strong></center>

![非均匀量化信噪比](images\非均匀量化信噪比.png)

<center><strong>图2 - u=100是信噪比的改善程度</strong></center>

可以看到对小信号有明显的改善。

![实验结果](images\实验结果.bmp)

<center><strong>图3 - 实验结果</strong></center>

根据实验结果来看，对小信号的拟合更好。