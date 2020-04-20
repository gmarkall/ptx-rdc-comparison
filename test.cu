extern __device__ int g;
__device__ int arr[10] = { 0 };

__device__ int f(int* x, int y, int i)
{
  int j = blockIdx.x;
  return x[i] + y + g + arr[j];
}

__global__ void f1(int* x, int* y)
{
  int i = threadIdx.x;
  y[i] = f(x, y[i], 2);
}
