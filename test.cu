extern __device__ int g;
__device__ int arr[10] = { 0 };

// __device__ function not called within the translation unit
__device__ int f_unused(int* x, int y, int i)
{
  int j = blockIdx.x;
  return x[i] + y + g + arr[j];
}


// __device__ function called within the translation unit that can't be inlined
__device__ __noinline__ int f_out(int* x, int y, int i)
{
  int j = blockIdx.x;
  return x[i] + y + g + arr[j];
}


// __device__ function called within the translation unit that is inlined
__device__ __forceinline__ int f_in(int* x, int y, int i)
{
  int j = blockIdx.x;
  return x[i] + y + arr[j];
}


__global__ void f1(int* x, int* y)
{
  int i = threadIdx.x;
  y[i] = f_out(x, y[i], 2);
  y[i] += f_in(x, y[i], 2);
}
