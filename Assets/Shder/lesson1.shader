Shader "Unlit/lesson1"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_MainColor("Main Color", Color) = (1.0,1.0,1.0,1.0)
		_ShadeValue("ShadeValue", , Range(0,1) == 1
			}
			SubShader
			{
				Tags { "RenderType" = "Opaque" }
				LOD 100

				Pass
				{
					CGPROGRAM
					#pragma vertex vert
					#pragma fragment frag
					// make fog work
					#pragma multi_compile_fog

					#include "UnityCG.cginc"

					struct appdata
					{
						float4 vertex : POSITION;
						float2 uv : TEXCOORD0;
					};

					struct v2f
					{
						float2 uv : TEXCOORD0;
						UNITY_FOG_COORDS(1)
						float4 vertex : SV_POSITION;
					};

					sampler2D _MainTex;
					float4 _MainTex_ST;
					float4 _MainColor;
					float ShadeValue;
					v2f vert(appdata v)
					{
						v2f o;
						o.vertex = UnityObjectToClipPos(v.vertex);
						o.uv = TRANSFORM_TEX(v.uv, _MainTex);
						UNITY_TRANSFER_FOG(o,o.vertex);
						return o;
					}

					fixed4 frag(v2f i) : SV_Target
					{
						float r = i.uv.x;
					    float g = i.uv.x;
					    float b = 0.5 + 0.5 * sin(_Time.x);
 					    float a = 1;

					    float4 yellow = float4(r, g, b, a);

						float4 color1 = float4(i.uv.x, i.uv.y, 1,1);
						float4 color2 = float4(1, 0, 1, 1);

						return color1 + color2;
					}
					ENDCG
				}
			}
}
