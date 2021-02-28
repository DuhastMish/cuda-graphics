

cbuffer ConstantBuffer : register(b0)
{
	matrix World;
	matrix View;
	matrix Projection;
	float4 vLightDir;
	float4 vLightColor;
	float4 vOutputColor;
	float3 Eye;
}


struct VS_INPUT
{
	float4 Pos : POSITION;
	float3 Norm : NORMAL;
};

struct PS_INPUT
{
	float4 Pos : SV_POSITION;
	float3 Norm : TEXCOORD0;
	float3 WorldPos : TEXCOORD1;
};


PS_INPUT VS(VS_INPUT input)
{
	PS_INPUT output = (PS_INPUT)0;
	output.WorldPos = mul(input.Pos, World);
	output.Pos = mul(input.Pos, World);
	output.Pos = mul(output.Pos, View);
	output.Pos = mul(output.Pos, Projection);
	output.Norm = mul(float4(input.Norm, 1), World).xyz;


	return output;
}


float4 PS(PS_INPUT input) : SV_Target
{
	float4 finalColor = 0;
	float4 intensity = 1.5f;
	float power = 20;
	float3 V = normalize(Eye - input.WorldPos);
	float3 L = -normalize(vLightDir.xyz);
	float3 R = reflect(normalize(L), normalize(input.Norm));

	finalColor += intensity * vLightColor * pow(saturate(dot(V, R)), power);

	finalColor.a = 1;
	return finalColor;
}


float4 PSSolid(PS_INPUT input) : SV_Target
{
	return vOutputColor;
}
