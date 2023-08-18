// Made with Amplify Shader Editor v1.9.1.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VFXUI/2D/Base_2D"
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

        [Main(z1,_KEYWORD,on,off)]_Blend("Blend", Float) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]_BlendRGB_Src1("BlendRGB_Src", Float) = 5
        [Enum(UnityEngine.Rendering.BlendMode)]_BlendRGB_Dst1("BlendRGB_Dst", Float) = 10
        [Enum(UnityEngine.Rendering.BlendOp)]_BlendONRGB("Blend ON RGB", Float) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]_BlendA_Src("BlendA_Src", Float) = 0
        [Enum(UnityEngine.Rendering.BlendMode)]_BlendA_Dst("BlendA_Dst", Float) = 0
        [Enum(UnityEngine.Rendering.BlendOp)]_BlendONA("Blend ON A", Float) = 0
        _Total_Int("Total_Int", Float) = 1
        [HDR]_MainColor("MainColor", Color) = (1,1,1,1)
        [Main(z2,_KEYWORD,on,off)]_Main("Main", Float) = 0
        [Sub(z3)]_ManiTexA_Int("ManiTexA_Int", Range( 0 , 1)) = 1
        [Sub(z2)]_MainTex_PowerInt("MainTex_PowerInt", Vector) = (1,1,0,0)
        [Main(z3,_KEYWORD,on,off)]_Noise_001("Noise_001", Float) = 0
        [Tex(z3)]_NoiseTex001("NoiseTex001", 2D) = "white" {}
        [Sub(z3)]_NoiseTex001_TilingOffset("NoiseTex001_Tiling&Offset", Vector) = (0,0,1,1)
        [Sub(z3)]_NoiseTex_001RotationSpeed("NoiseTex_001RotationSpeed", Vector) = (0,0,0,0)
        [Sub(z3)]_NoiseTex_001PannerSpeed("NoiseTex_001PannerSpeed", Vector) = (0,0,1,0)
        [Sub(z3)]_NoiseTex001_PowerMul("NoiseTex001_Power&Mul", Vector) = (1,1,0,0)
        [Main(z4,_KEYWORD,on,off)]_Noise_002("Noise_002", Float) = 0
        [Tex(z4)]_NoiseTex002("NoiseTex002", 2D) = "white" {}
        [Sub(z4)]_NoiseTex002_TilingOffset("NoiseTex002_Tiling&Offset", Vector) = (0,0,1,1)
        [Sub(z4)]_NoiseTex_002RotationSpeed("NoiseTex_002RotationSpeed", Vector) = (0,0,0,0)
        [Sub(z4)]_NoiseTex_002PannerSpeed("NoiseTex_002PannerSpeed", Vector) = (0,0,1,0)
        [Sub(z4)]_NoiseTex002_PowerMul("NoiseTex002_Power&Mul", Vector) = (1,1,0,0)
        [Main(z5,_KEYWORD,on,off)]_MaskTex_001("MaskTex_001", Float) = 0
        [Tex(z5)]_MaskTex001("MaskTex001", 2D) = "white" {}
        [Sub(z5)]_MaskTex001_TilingOffset("MaskTex001_Tiling&Offset", Vector) = (0,0,1,1)
        [Sub(z5)]_MaskTex001_RotationSpeed("MaskTex001_RotationSpeed", Vector) = (0,0,0,0)
        [Sub(z5)]_MaskTex001_PannerSpeed("MaskTex001_PannerSpeed", Vector) = (0,0,1,0)
        [Sub(z5)]_MaskTex001_PowerMul("MaskTex001_Power&Mul", Vector) = (1,1,0,0)
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
        Blend [_BlendRGB_Src1] [_BlendRGB_Dst1]
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

            uniform float _BlendA_Src;
            uniform float _BlendA_Dst;
            uniform float _BlendRGB_Dst1;
            uniform float _BlendONRGB;
            uniform float _BlendONA;
            uniform float _BlendRGB_Src1;
            uniform float _Blend;
            uniform float _Main;
            uniform float _Noise_001;
            uniform float _Noise_002;
            uniform float _MaskTex_001;
            uniform float2 _MainTex_PowerInt;
            uniform sampler2D _NoiseTex001;
            uniform float4 _NoiseTex_001PannerSpeed;
            uniform float4 _NoiseTex001_TilingOffset;
            uniform float4 _NoiseTex_001RotationSpeed;
            uniform float2 _NoiseTex001_PowerMul;
            uniform sampler2D _NoiseTex002;
            uniform float4 _NoiseTex_002PannerSpeed;
            uniform float4 _NoiseTex002_TilingOffset;
            uniform float4 _NoiseTex_002RotationSpeed;
            uniform float2 _NoiseTex002_PowerMul;
            uniform sampler2D _MaskTex001;
            uniform float4 _MaskTex001_PannerSpeed;
            uniform float4 _MaskTex001_TilingOffset;
            uniform float4 _MaskTex001_RotationSpeed;
            uniform float2 _MaskTex001_PowerMul;
            uniform float _ManiTexA_Int;
            uniform float _Total_Int;
            uniform float4 _MainColor;

            
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

                float2 uv_MainTex = IN.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
                float4 temp_cast_1 = (_MainTex_PowerInt.x).xxxx;
                float4 break100 = ( pow( tex2D( _MainTex, uv_MainTex ) , temp_cast_1 ) * _MainTex_PowerInt.y );
                float3 appendResult101 = (float3(break100.x , break100.y , break100.z));
                float3 MainTex_RGB45 = appendResult101;
                float4 break12_g33 = _NoiseTex_001PannerSpeed;
                float mulTime11_g33 = _Time.y * break12_g33.z;
                float2 appendResult13_g33 = (float2(break12_g33.x , break12_g33.y));
                float2 texCoord111 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
                float2 appendResult11_g34 = (float2(( ( texCoord111.x + _NoiseTex001_TilingOffset.z ) * _NoiseTex001_TilingOffset.x ) , ( ( texCoord111.y + _NoiseTex001_TilingOffset.w ) * _NoiseTex001_TilingOffset.y )));
                float4 break3_g35 = _NoiseTex_001RotationSpeed;
                float2 appendResult2_g35 = (float2(break3_g35.x , break3_g35.y));
                float mulTime5_g35 = _Time.y * break3_g35.z;
                float cos12_g35 = cos( ( mulTime5_g35 + break3_g35.w ) );
                float sin12_g35 = sin( ( mulTime5_g35 + break3_g35.w ) );
                float2 rotator12_g35 = mul( appendResult11_g34 - appendResult2_g35 , float2x2( cos12_g35 , -sin12_g35 , sin12_g35 , cos12_g35 )) + appendResult2_g35;
                float2 panner6_g33 = ( ( mulTime11_g33 + break12_g33.w ) * appendResult13_g33 + rotator12_g35);
                float4 temp_cast_3 = (_NoiseTex001_PowerMul.x).xxxx;
                float4 temp_output_127_0 = ( pow( tex2D( _NoiseTex001, panner6_g33 ) , temp_cast_3 ) * _NoiseTex001_PowerMul.y );
                float3 NoiseTex001_RGB40 = (temp_output_127_0).xyz;
                float4 break12_g40 = _NoiseTex_002PannerSpeed;
                float mulTime11_g40 = _Time.y * break12_g40.z;
                float2 appendResult13_g40 = (float2(break12_g40.x , break12_g40.y));
                float2 texCoord117 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
                float2 appendResult11_g41 = (float2(( ( texCoord117.x + _NoiseTex002_TilingOffset.z ) * _NoiseTex002_TilingOffset.x ) , ( ( texCoord117.y + _NoiseTex002_TilingOffset.w ) * _NoiseTex002_TilingOffset.y )));
                float4 break3_g42 = _NoiseTex_002RotationSpeed;
                float2 appendResult2_g42 = (float2(break3_g42.x , break3_g42.y));
                float mulTime5_g42 = _Time.y * break3_g42.z;
                float cos12_g42 = cos( ( mulTime5_g42 + break3_g42.w ) );
                float sin12_g42 = sin( ( mulTime5_g42 + break3_g42.w ) );
                float2 rotator12_g42 = mul( appendResult11_g41 - appendResult2_g42 , float2x2( cos12_g42 , -sin12_g42 , sin12_g42 , cos12_g42 )) + appendResult2_g42;
                float2 panner6_g40 = ( ( mulTime11_g40 + break12_g40.w ) * appendResult13_g40 + rotator12_g42);
                float4 temp_cast_5 = (_NoiseTex002_PowerMul.x).xxxx;
                float4 temp_output_131_0 = ( pow( tex2D( _NoiseTex002, panner6_g40 ) , temp_cast_5 ) * _NoiseTex002_PowerMul.y );
                float3 NoiseTex002_RGB125 = (temp_output_131_0).xyz;
                float4 break12_g49 = _MaskTex001_PannerSpeed;
                float mulTime11_g49 = _Time.y * break12_g49.z;
                float2 appendResult13_g49 = (float2(break12_g49.x , break12_g49.y));
                float2 texCoord176 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
                float2 appendResult11_g46 = (float2(( ( texCoord176.x + _MaskTex001_TilingOffset.z ) * _MaskTex001_TilingOffset.x ) , ( ( texCoord176.y + _MaskTex001_TilingOffset.w ) * _MaskTex001_TilingOffset.y )));
                float4 break3_g47 = _MaskTex001_RotationSpeed;
                float2 appendResult2_g47 = (float2(break3_g47.x , break3_g47.y));
                float mulTime5_g47 = _Time.y * break3_g47.z;
                float cos12_g47 = cos( ( mulTime5_g47 + break3_g47.w ) );
                float sin12_g47 = sin( ( mulTime5_g47 + break3_g47.w ) );
                float2 rotator12_g47 = mul( appendResult11_g46 - appendResult2_g47 , float2x2( cos12_g47 , -sin12_g47 , sin12_g47 , cos12_g47 )) + appendResult2_g47;
                float2 panner6_g49 = ( ( mulTime11_g49 + break12_g49.w ) * appendResult13_g49 + rotator12_g47);
                float4 temp_cast_7 = (_MaskTex001_PowerMul.x).xxxx;
                float4 temp_output_182_0 = ( pow( tex2D( _MaskTex001, panner6_g49 ) , temp_cast_7 ) * _MaskTex001_PowerMul.y );
                float3 MaskTex001_RGB186 = (temp_output_182_0).xyz;
                float MainTex_A46 = break100.w;
                float NoiseTex001_A41 = (temp_output_127_0).w;
                float NoiseTex002_A124 = (temp_output_131_0).w;
                float MaskTex001_A185 = (temp_output_182_0).w;
                float4 appendResult21 = (float4(( MainTex_RGB45 * NoiseTex001_RGB40 * NoiseTex002_RGB125 * MaskTex001_RGB186 ) , ( ( _ManiTexA_Int * MainTex_A46 ) + ( MainTex_A46 * NoiseTex001_A41 * NoiseTex002_A124 * MaskTex001_A185 ) )));
                float4 Main77 = saturate( appendResult21 );
                

                half4 color = ( Main77 * _Total_Int * IN.color * _MainColor );

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
Node;AmplifyShaderEditor.CommentaryNode;188;-3830.4,1433.775;Inherit;False;2466.965;559.6433;Comment;15;174;175;176;177;178;179;180;182;184;181;186;185;183;173;187;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;79;-1165.138,-56.94111;Inherit;False;1694.187;661.8237;Comment;18;44;42;77;65;43;47;25;4;21;72;132;133;134;135;168;169;170;171;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;49;-3775.972,127.9656;Inherit;False;2369.129;535.8492;Comment;15;110;104;11;109;36;108;111;76;106;40;41;12;24;127;128;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;48;-3147.986,-256.7325;Inherit;False;1734.295;298.1684;Comment;9;3;46;1;45;98;100;101;102;103;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;60;1283.173,12.89762;Float;False;True;-1;2;ASEMaterialInspector;0;3;VFXUI/2D/Base_2D;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;True;True;3;1;True;_BlendRGB_Src1;10;True;_BlendRGB_Dst1;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;True;True;True;True;True;0;True;_ColorMask;False;False;False;False;False;False;False;True;True;0;True;_Stencil;255;True;_StencilReadMask;255;True;_StencilWriteMask;0;True;_StencilComp;0;True;_StencilOp;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;0;True;unity_GUIZTestMode;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;0;;0;0;Standard;0;0;1;True;False;;False;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;1134.981,12.19754;Inherit;False;4;4;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.VertexColorNode;63;832.9807,62.19749;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;21;-310.5006,5.653091;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-444.2795,5.310295;Inherit;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;80;835.4281,-453.7308;Inherit;False;852;373;Comment;7;87;86;85;84;83;82;81;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;81;1276.259,-404.9379;Inherit;False;Property;_BlendA_Src;BlendA_Src;8;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;1277.259,-323.9379;Inherit;False;Property;_BlendA_Dst;BlendA_Dst;9;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;1016.428,-321.7308;Inherit;False;Property;_BlendRGB_Dst1;BlendRGB_Dst;6;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.BlendMode;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;1013.048,-230.4049;Inherit;False;Property;_BlendONRGB;Blend ON RGB;7;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendOp;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;85;1278.048,-233.4049;Inherit;False;Property;_BlendONA;Blend ON A;10;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.BlendOp;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;654.4683,5.71463;Inherit;False;77;Main;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;86;1016.428,-403.7308;Inherit;False;Property;_BlendRGB_Src1;BlendRGB_Src;5;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;2;;;False;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;983.9807,33.1975;Inherit;False;Property;_Total_Int;Total_Int;11;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;1;-3117.203,-199.5566;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;45;-1634.16,-200.2093;Inherit;False;MainTex_RGB;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;100;-2032.091,-195.2614;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;101;-1817.091,-195.2614;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;98;-2305.714,-197.2153;Inherit;False;Power_int;-1;;31;d0d7f0b0d1b8ce24aac4532a8c4295be;0;3;5;FLOAT4;0,0,0,0;False;6;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;87;864.1781,-403.1099;Inherit;False;Property;_Blend;Blend;0;0;Create;True;0;0;0;True;2;Main(z1,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;46;-1633.749,-124.9885;Inherit;False;MainTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;103;-2556.67,-57.36127;Inherit;False;Property;_Main;Main;13;0;Create;True;0;0;0;True;2;Main(z2,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;106;-2979.198,265.9011;Inherit;False;Panner;3;;33;d249d02365bdde94f908c0db1541c89b;0;2;7;FLOAT2;1,1;False;14;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;76;-3497.219,268.7301;Inherit;False;UV;-1;;34;0f10a5ade4108734eb494334c6d5de60;0;6;27;FLOAT;0;False;28;FLOAT;0;False;18;FLOAT;1;False;24;FLOAT;1;False;25;FLOAT;0;False;26;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;111;-3747.944,161.2128;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;108;-3268.633,265.9013;Inherit;False;Rotation;1;;35;41319ecd5aaef6c4b96516d9df6d7c3b;0;2;9;FLOAT2;1,1;False;10;FLOAT4;0,0,0,0;False;1;FLOAT2;7
Node;AmplifyShaderEditor.CommentaryNode;112;-3778.818,761.6625;Inherit;False;2369.129;535.8492;Comment;15;125;124;123;122;121;120;119;118;117;116;115;114;113;130;131;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;126;1060.746,153.8431;Inherit;False;Property;_MainColor;MainColor;12;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;72;-168.824,6.298807;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;-36.95135,2.257637;Inherit;False;Main;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;-1625.808,325.1346;Inherit;False;NoiseTex001_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;12;-1831.202,225.7875;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;24;-1826.203,318.7872;Inherit;False;FLOAT;3;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;104;-2780.523,465.6826;Inherit;False;Property;_Noise_001;Noise_001;16;0;Create;True;0;0;0;True;2;Main(z3,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;127;-2130.254,230.8431;Inherit;False;Power_int;-1;;39;d0d7f0b0d1b8ce24aac4532a8c4295be;0;3;5;FLOAT4;0,0,0,0;False;6;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;40;-1624.808,229.1345;Inherit;False;NoiseTex001_RGB;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;44;-869.1379,2.058898;Inherit;False;45;MainTex_RGB;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;-1086.785,50.83264;Inherit;False;125;NoiseTex002_RGB;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;-461.0423,274.1245;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;-815.3445,346.8826;Inherit;False;41;NoiseTex001_A;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-623.0328,326.2988;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-681.9941,24.14351;Inherit;False;40;NoiseTex001_RGB;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;133;-1019.785,369.8326;Inherit;False;124;NoiseTex002_A;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-1015.085,265.3782;Inherit;False;46;MainTex_A;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;134;-652.679,225.8206;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-940.679,219.8206;Inherit;False;Property;_ManiTexA_Int;ManiTexA_Int;14;0;Create;True;0;0;0;False;1;Sub(z3);False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;171;-855.9146,465.0652;Inherit;False;-1;;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;110;-3248.107,365.4579;Inherit;False;Property;_NoiseTex_001PannerSpeed;NoiseTex_001PannerSpeed;20;0;Create;True;0;0;0;False;2;Sub(z3);;False;0,0,1,0;0,0,1,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;109;-3574.45,458.8564;Inherit;False;Property;_NoiseTex_001RotationSpeed;NoiseTex_001RotationSpeed;19;0;Create;True;0;0;0;False;2;Sub(z3);;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;36;-3762.94,286.7033;Inherit;False;Property;_NoiseTex001_TilingOffset;NoiseTex001_Tiling&Offset;18;0;Create;True;0;0;0;False;1;Sub(z3);False;0,0,1,1;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;128;-2388.254,232.8431;Inherit;False;Property;_NoiseTex001_PowerMul;NoiseTex001_Power&Mul;21;0;Create;True;0;0;0;False;1;Sub(z3);False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;102;-2549.091,-203.2614;Inherit;False;Property;_MainTex_PowerInt;MainTex_PowerInt;15;0;Create;True;0;0;0;False;1;Sub(z2);False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;3;-2952.752,-203.3374;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-2704.206,230.7875;Inherit;True;Property;_NoiseTex001;NoiseTex001;17;0;Create;True;0;0;0;False;2;Tex(z3);;False;-1;None;44e2409956f42d84089d9dd55fc164b1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;121;-2707.052,864.4845;Inherit;True;Property;_NoiseTex002;NoiseTex002;23;0;Create;True;0;0;0;False;2;Tex(z4);;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;169;-658.9146,132.0652;Inherit;False;-1;;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;168;-881.9146,78.06525;Inherit;False;186;MaskTex001_RGB;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;115;-2982.044,899.598;Inherit;False;Panner;3;;40;d249d02365bdde94f908c0db1541c89b;0;2;7;FLOAT2;1,1;False;14;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;116;-3500.065,902.4271;Inherit;False;UV;-1;;41;0f10a5ade4108734eb494334c6d5de60;0;6;27;FLOAT;0;False;28;FLOAT;0;False;18;FLOAT;1;False;24;FLOAT;1;False;25;FLOAT;0;False;26;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;117;-3750.79,794.9098;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;118;-3271.479,899.5983;Inherit;False;Rotation;1;;42;41319ecd5aaef6c4b96516d9df6d7c3b;0;2;9;FLOAT2;1,1;False;10;FLOAT4;0,0,0,0;False;1;FLOAT2;7
Node;AmplifyShaderEditor.Vector4Node;120;-3577.335,1092.553;Inherit;False;Property;_NoiseTex_002RotationSpeed;NoiseTex_002RotationSpeed;25;0;Create;True;0;0;0;False;2;Sub(z4);;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;119;-3769.569,920.4003;Inherit;False;Property;_NoiseTex002_TilingOffset;NoiseTex002_Tiling&Offset;24;0;Create;True;0;0;0;False;1;Sub(z4);False;0,0,1,1;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;123;-3250.953,998.0988;Inherit;False;Property;_NoiseTex_002PannerSpeed;NoiseTex_002PannerSpeed;26;0;Create;True;0;0;0;False;2;Sub(z4);;False;0,0,1,0;0,0,1,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwizzleNode;114;-1893.048,866.4845;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;131;-2131.181,868.8663;Inherit;False;Power_int;-1;;43;d0d7f0b0d1b8ce24aac4532a8c4295be;0;3;5;FLOAT4;0,0,0,0;False;6;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector2Node;130;-2372.181,862.8663;Inherit;False;Property;_NoiseTex002_PowerMul;NoiseTex002_Power&Mul;27;0;Create;True;0;0;0;False;1;Sub(z4);False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;124;-1628.655,958.8315;Inherit;False;NoiseTex002_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;125;-1627.655,863.8315;Inherit;False;NoiseTex002_RGB;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;170;-826.9146,403.0652;Inherit;False;185;MaskTex001_A;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-2783.369,1099.38;Inherit;False;Property;_Noise_002;Noise_002;22;0;Create;True;0;0;0;True;2;Main(z4,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;175;-3510.896,1591.292;Inherit;False;UV;-1;;46;0f10a5ade4108734eb494334c6d5de60;0;6;27;FLOAT;0;False;28;FLOAT;0;False;18;FLOAT;1;False;24;FLOAT;1;False;25;FLOAT;0;False;26;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;176;-3761.621,1483.775;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;177;-3282.31,1588.463;Inherit;False;Rotation;1;;47;41319ecd5aaef6c4b96516d9df6d7c3b;0;2;9;FLOAT2;1,1;False;10;FLOAT4;0,0,0,0;False;1;FLOAT2;7
Node;AmplifyShaderEditor.FunctionNode;182;-2085.012,1560.069;Inherit;False;Power_int;-1;;48;d0d7f0b0d1b8ce24aac4532a8c4295be;0;3;5;FLOAT4;0,0,0,0;False;6;FLOAT;1;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SwizzleNode;181;-1835.879,1554.687;Inherit;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;187;-2748.184,1783.986;Inherit;False;Property;_MaskTex_001;MaskTex_001;28;0;Create;True;0;0;0;True;2;Main(z5,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;179;-3780.4,1608.265;Inherit;False;Property;_MaskTex001_TilingOffset;MaskTex001_Tiling&Offset;30;0;Create;True;0;0;0;False;1;Sub(z5);False;0,0,1,1;1,1,1,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;178;-3588.166,1781.418;Inherit;False;Property;_MaskTex001_RotationSpeed;MaskTex001_RotationSpeed;31;0;Create;True;0;0;0;False;2;Sub(z5);;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;184;-2326.012,1553.069;Inherit;False;Property;_MaskTex001_PowerMul;MaskTex001_Power&Mul;33;0;Create;True;0;0;0;False;1;Sub(z5);False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;186;-1606.435,1545.056;Inherit;False;MaskTex001_RGB;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;185;-1607.435,1658.056;Inherit;False;MaskTex001_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;174;-2992.875,1588.463;Inherit;False;Panner;3;;49;d249d02365bdde94f908c0db1541c89b;0;2;7;FLOAT2;1,1;False;14;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;180;-3260.784,1686.964;Inherit;False;Property;_MaskTex001_PannerSpeed;MaskTex001_PannerSpeed;32;0;Create;True;0;0;0;False;2;Sub(z5);;False;0,0,1,0;0,0,1,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;173;-2674.939,1541.846;Inherit;True;Property;_MaskTex001;MaskTex001;29;0;Create;True;0;0;0;False;2;Tex(z5);;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwizzleNode;183;-1840.88,1653.687;Inherit;False;FLOAT;3;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;113;-1887.049,962.4841;Inherit;False;FLOAT;3;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
WireConnection;60;0;61;0
WireConnection;61;0;78;0
WireConnection;61;1;62;0
WireConnection;61;2;63;0
WireConnection;61;3;126;0
WireConnection;21;0;4;0
WireConnection;21;3;25;0
WireConnection;4;0;44;0
WireConnection;4;1;42;0
WireConnection;4;2;132;0
WireConnection;4;3;168;0
WireConnection;45;0;101;0
WireConnection;100;0;98;0
WireConnection;101;0;100;0
WireConnection;101;1;100;1
WireConnection;101;2;100;2
WireConnection;98;5;3;0
WireConnection;98;6;102;1
WireConnection;98;3;102;2
WireConnection;46;0;100;3
WireConnection;106;7;108;7
WireConnection;106;14;110;0
WireConnection;76;27;111;1
WireConnection;76;28;111;2
WireConnection;76;18;36;1
WireConnection;76;24;36;2
WireConnection;76;25;36;3
WireConnection;76;26;36;4
WireConnection;108;9;76;0
WireConnection;108;10;109;0
WireConnection;72;0;21;0
WireConnection;77;0;72;0
WireConnection;41;0;24;0
WireConnection;12;0;127;0
WireConnection;24;0;127;0
WireConnection;127;5;11;0
WireConnection;127;6;128;1
WireConnection;127;3;128;2
WireConnection;40;0;12;0
WireConnection;25;0;134;0
WireConnection;25;1;65;0
WireConnection;65;0;47;0
WireConnection;65;1;43;0
WireConnection;65;2;133;0
WireConnection;65;3;170;0
WireConnection;134;0;135;0
WireConnection;134;1;47;0
WireConnection;3;0;1;0
WireConnection;11;1;106;0
WireConnection;121;1;115;0
WireConnection;115;7;118;7
WireConnection;115;14;123;0
WireConnection;116;27;117;1
WireConnection;116;28;117;2
WireConnection;116;18;119;1
WireConnection;116;24;119;2
WireConnection;116;25;119;3
WireConnection;116;26;119;4
WireConnection;118;9;116;0
WireConnection;118;10;120;0
WireConnection;114;0;131;0
WireConnection;131;5;121;0
WireConnection;131;6;130;1
WireConnection;131;3;130;2
WireConnection;124;0;113;0
WireConnection;125;0;114;0
WireConnection;175;27;176;1
WireConnection;175;28;176;2
WireConnection;175;18;179;1
WireConnection;175;24;179;2
WireConnection;175;25;179;3
WireConnection;175;26;179;4
WireConnection;177;9;175;0
WireConnection;177;10;178;0
WireConnection;182;5;173;0
WireConnection;182;6;184;1
WireConnection;182;3;184;2
WireConnection;181;0;182;0
WireConnection;186;0;181;0
WireConnection;185;0;183;0
WireConnection;174;7;177;7
WireConnection;174;14;180;0
WireConnection;173;1;174;0
WireConnection;183;0;182;0
WireConnection;113;0;131;0
ASEEND*/
//CHKSM=BDEBFB9919EA958F8950FB3D4929E684B10DAD23