// Made with Amplify Shader Editor v1.9.1.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Taail"
{
    Properties
    {
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1,1,1,1)

        _StencilComp ("Stencil Comparison", Float) = 8
        _Stencil ("Stencil ID", Float) = 0
        _StencilOp ("Stencil Operation", Float) = 0
        _StencilWriteMask ("Stencil Write Mask", Float) = 255
        _StencilReadMask ("Stencil Read Mask", Float) = 255

        _ColorMask ("Color Mask", Float) = 15

        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", Float) = 0

        _Main_Int("Main_Int", Float) = 1
        [HDR]_Color0("Color 0", Color) = (1,1,1,1)
        _MaskTex001_UV("MaskTex001_UV", Vector) = (1,1,0,0)
        _MaskTex001("MaskTex001", 2D) = "white" {}
        _MaskTex001_Speed("MaskTex001_Speed", Vector) = (0,0,0,0)
        _MaskTex002_UV("MaskTex002_UV", Vector) = (1,1,0,0)
        _MaskTex002("MaskTex002", 2D) = "white" {}
        _MaskTex002_Speed("MaskTex002_Speed", Vector) = (0,0,0,0)
        _MaskTex003("MaskTex003", 2D) = "white" {}
        _MaskTex004("MaskTex004", 2D) = "white" {}
        [HideInInspector] _texcoord( "", 2D ) = "white" {}

    }

    SubShader
    {
		LOD 0

        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }

        Stencil
        {
        	Ref [_Stencil]
        	ReadMask [_StencilReadMask]
        	WriteMask [_StencilWriteMask]
        	Comp [_StencilComp]
        	Pass [_StencilOp]
        }


        Cull Off
        Lighting Off
        ZWrite Off
        ZTest [unity_GUIZTestMode]
        Blend One OneMinusSrcAlpha
        ColorMask [_ColorMask]

        
        Pass
        {
            Name "Default"
        CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile_local _ UNITY_UI_CLIP_RECT
            #pragma multi_compile_local _ UNITY_UI_ALPHACLIP

            #include "UnityShaderVariables.cginc"
            #define ASE_NEEDS_FRAG_COLOR


            struct appdata_t
            {
                float4 vertex   : POSITION;
                float4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed4 color    : COLOR;
                float2 texcoord  : TEXCOORD0;
                float4 worldPosition : TEXCOORD1;
                float4  mask : TEXCOORD2;
                UNITY_VERTEX_OUTPUT_STEREO
                
            };

            sampler2D _MainTex;
            fixed4 _Color;
            fixed4 _TextureSampleAdd;
            float4 _ClipRect;
            float4 _MainTex_ST;
            float _UIMaskSoftnessX;
            float _UIMaskSoftnessY;

            uniform sampler2D _MaskTex001;
            uniform float4 _MaskTex001_Speed;
            uniform float4 _MaskTex001_UV;
            uniform sampler2D _MaskTex002;
            uniform float4 _MaskTex002_Speed;
            uniform float4 _MaskTex002_UV;
            uniform sampler2D _MaskTex003;
            uniform float4 _MaskTex003_ST;
            uniform sampler2D _MaskTex004;
            uniform float4 _MaskTex004_ST;
            uniform float _Main_Int;
            uniform float4 _Color0;

            
            v2f vert(appdata_t v )
            {
                v2f OUT;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);

                

                v.vertex.xyz +=  float3( 0, 0, 0 ) ;

                float4 vPosition = UnityObjectToClipPos(v.vertex);
                OUT.worldPosition = v.vertex;
                OUT.vertex = vPosition;

                float2 pixelSize = vPosition.w;
                pixelSize /= float2(1, 1) * abs(mul((float2x2)UNITY_MATRIX_P, _ScreenParams.xy));

                float4 clampedRect = clamp(_ClipRect, -2e10, 2e10);
                float2 maskUV = (v.vertex.xy - clampedRect.xy) / (clampedRect.zw - clampedRect.xy);
                OUT.texcoord = v.texcoord;
                OUT.mask = float4(v.vertex.xy * 2 - clampedRect.xy - clampedRect.zw, 0.25 / (0.25 * half2(_UIMaskSoftnessX, _UIMaskSoftnessY) + abs(pixelSize.xy)));

                OUT.color = v.color * _Color;
                return OUT;
            }

            fixed4 frag(v2f IN ) : SV_Target
            {
                //Round up the alpha color coming from the interpolator (to 1.0/256.0 steps)
                //The incoming alpha could have numerical instability, which makes it very sensible to
                //HDR color transparency blend, when it blends with the world's texture.
                const half alphaPrecision = half(0xff);
                const half invAlphaPrecision = half(1.0/alphaPrecision);
                IN.color.a = round(IN.color.a * alphaPrecision)*invAlphaPrecision;

                float4 break12_g3 = _MaskTex001_Speed;
                float mulTime11_g3 = _Time.y * break12_g3.z;
                float2 appendResult13_g3 = (float2(break12_g3.x , break12_g3.y));
                float2 texCoord1_g5 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
                float2 appendResult11_g5 = (float2(( ( texCoord1_g5.x + _MaskTex001_UV.z ) * _MaskTex001_UV.x ) , ( ( texCoord1_g5.y + _MaskTex001_UV.w ) * _MaskTex001_UV.y )));
                float2 panner6_g3 = ( ( mulTime11_g3 + break12_g3.w ) * appendResult13_g3 + appendResult11_g5);
                float4 break12_g4 = _MaskTex002_Speed;
                float mulTime11_g4 = _Time.y * break12_g4.z;
                float2 appendResult13_g4 = (float2(break12_g4.x , break12_g4.y));
                float2 texCoord1_g2 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
                float2 appendResult11_g2 = (float2(( ( texCoord1_g2.x + _MaskTex002_UV.z ) * _MaskTex002_UV.x ) , ( ( texCoord1_g2.y + _MaskTex002_UV.w ) * _MaskTex002_UV.y )));
                float2 panner6_g4 = ( ( mulTime11_g4 + break12_g4.w ) * appendResult13_g4 + appendResult11_g2);
                float2 uv_MaskTex003 = IN.texcoord.xy * _MaskTex003_ST.xy + _MaskTex003_ST.zw;
                float2 uv_MaskTex004 = IN.texcoord.xy * _MaskTex004_ST.xy + _MaskTex004_ST.zw;
                

                half4 color = ( ( ( tex2D( _MaskTex001, panner6_g3 ) * tex2D( _MaskTex002, panner6_g4 ) * tex2D( _MaskTex003, uv_MaskTex003 ) * tex2D( _MaskTex004, uv_MaskTex004 ) ) * IN.color ) * _Main_Int * _Color0 );

                #ifdef UNITY_UI_CLIP_RECT
                half2 m = saturate((_ClipRect.zw - _ClipRect.xy - abs(IN.mask.xy)) * IN.mask.zw);
                color.a *= m.x * m.y;
                #endif

                #ifdef UNITY_UI_ALPHACLIP
                clip (color.a - 0.001);
                #endif

                color.rgb *= color.a;

                return color;
            }
        ENDCG
        }
    }
    CustomEditor "ASEMaterialInspector"
	
	Fallback Off
}
/*ASEBEGIN
Version=19108
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-245,-4.5;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;7;-1065,230.5;Inherit;False;UV;-1;;2;0f10a5ade4108734eb494334c6d5de60;0;6;27;FLOAT;0;False;28;FLOAT;0;False;18;FLOAT;1;False;24;FLOAT;1;False;25;FLOAT;0;False;26;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;8;-855,19.5;Inherit;False;Panner;-1;;3;d249d02365bdde94f908c0db1541c89b;0;2;7;FLOAT2;1,1;False;14;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;9;-857,230.5;Inherit;False;Panner;-1;;4;d249d02365bdde94f908c0db1541c89b;0;2;7;FLOAT2;1,1;False;14;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;-585,200.5;Inherit;True;Property;_MaskTex002;MaskTex002;6;0;Create;True;0;0;0;False;0;False;-1;None;302ab7a914fac0b4083dd0a890e66569;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-587,-10.5;Inherit;True;Property;_MaskTex001;MaskTex001;3;0;Create;True;0;0;0;False;0;False;-1;None;0f30dbb6d9f86554886325d378163d4c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;11;-1277,247.5;Inherit;False;Property;_MaskTex002_Speed;MaskTex002_Speed;7;0;Create;True;0;0;0;False;0;False;0,0,0,0;-0.5,0,1,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;6;-1064,16.5;Inherit;False;UV;-1;;5;0f10a5ade4108734eb494334c6d5de60;0;6;27;FLOAT;0;False;28;FLOAT;0;False;18;FLOAT;1;False;24;FLOAT;1;False;25;FLOAT;0;False;26;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;10;-1278,36.5;Inherit;False;Property;_MaskTex001_Speed;MaskTex001_Speed;4;0;Create;True;0;0;0;False;0;False;0,0,0,0;-0.2,0,1,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;12;-1458,37.5;Inherit;False;Property;_MaskTex001_UV;MaskTex001_UV;2;0;Create;True;0;0;0;False;0;False;1,1,0,0;0.32,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;13;-1455,251.5;Inherit;False;Property;_MaskTex002_UV;MaskTex002_UV;5;0;Create;True;0;0;0;False;0;False;1,1,0,0;1.74,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;199,-13;Float;False;True;-1;2;ASEMaterialInspector;0;3;Taail;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;False;True;3;1;False;;10;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;True;True;True;True;True;0;True;_ColorMask;False;False;False;False;False;False;False;True;True;0;True;_Stencil;255;True;_StencilReadMask;255;True;_StencilWriteMask;0;True;_StencilComp;0;True;_StencilOp;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;0;True;unity_GUIZTestMode;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;0;;0;0;Standard;0;0;1;True;False;;False;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-78,-6.5;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;88,-7.5;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-72,96.5;Inherit;False;Property;_Main_Int;Main_Int;0;0;Create;True;0;0;0;False;0;False;1;5.52;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;16;-93,170.5;Inherit;False;Property;_Color0;Color 0;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;0.7783542,0.4103774,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;17;-581,411.5;Inherit;True;Property;_MaskTex003;MaskTex003;8;0;Create;True;0;0;0;False;0;False;-1;None;b21d2f17108a23b448d4835de361ae63;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;4;-266,170.5;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-574,621.5;Inherit;True;Property;_MaskTex004;MaskTex004;9;0;Create;True;0;0;0;False;0;False;-1;None;b21d2f17108a23b448d4835de361ae63;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
WireConnection;3;0;1;0
WireConnection;3;1;2;0
WireConnection;3;2;17;0
WireConnection;3;3;18;0
WireConnection;7;18;13;1
WireConnection;7;24;13;2
WireConnection;7;25;13;3
WireConnection;7;26;13;4
WireConnection;8;7;6;0
WireConnection;8;14;10;0
WireConnection;9;7;7;0
WireConnection;9;14;11;0
WireConnection;2;1;9;0
WireConnection;1;1;8;0
WireConnection;6;18;12;1
WireConnection;6;24;12;2
WireConnection;6;25;12;3
WireConnection;6;26;12;4
WireConnection;0;0;14;0
WireConnection;5;0;3;0
WireConnection;5;1;4;0
WireConnection;14;0;5;0
WireConnection;14;1;15;0
WireConnection;14;2;16;0
ASEEND*/
//CHKSM=D1C0FEB5056A2B6686F5815014C192F3C178B9D7