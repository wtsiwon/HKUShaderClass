Shader "Unlit/lesson1"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_MossTex("Moss Texture", 2D) = "white" {}
		_MixTex("Mix Texture", 2D) = "white" {}
		_MainColor("Main Color", Color) = (1.0,1.0,1.0,1.0)
		_MossSlider("Moss Value", Range(0,1))= 1
			}
			SubShader
			{
				Tags { "RenderType" = "Transparent" "Queue" = "Transparent"}
				Blend SrcAlpha OneMinusSrcColor
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
					sampler2D _MossTex;
					sampler2D _MixTex;
					float4 _MossTex_ST;
					float4 _MainColor;
					float _MossSlider;
					
					
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
						float2 uv = float2(1,1) - i.uv;
						float4 bricks = tex2D(_MainTex, i.uv);
						float4 moss = tex2D(_MossTex, uv);

						float mix = tex2D(_MixTex, uv).r;
						mix *= _MossSlider;

						//color = bricks * hereGoesMoss + moss * (1.0 - hereComesMoss)
						float4 result = bricks;
						return float4(result.rgb, _MossSlider);
					}
					ENDCG
				}
			}
}
