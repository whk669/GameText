// Made with Amplify Shader Editor v1.9.1.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "VFXUI/2D/Face"
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
        [Main(z2,_KEYWORD,on,off)]_Main("Main", Float) = 0
        [Tex(z2)]_Main_Int("Main_Int", Float) = 1
        [HDR][Tex(z2)]_MainColor("MainColor", Color) = (1,1,1,1)
        [Tex(z5)]_FrontHeight_Tiling("FrontHeight_Tiling", Float) = 1
        [Tex(z5)]_Front_HeightTex("Front_HeightTex", 2D) = "white" {}
        [Tex(z5)]_Front_Parallax("Front_Parallax", Range( -0.01 , 1)) = -0.01
        [Main(z3,_KEYWORD,on,off)]_Front("Front", Float) = 0
        [Tex(z3)]_FrontTex("FrontTex", 2D) = "white" {}
        [Main(z6,_KEYWORD,on,off)]_Back_Height("Back_Height", Float) = 0
        [Tex(z6)]_BackHeight_Tiling("BackHeight_Tiling", Float) = 1
        [Tex(z6)]_Back_HeightTex("Back_HeightTex", 2D) = "white" {}
        [Tex(z6)]_Back_Parallax("Back_Parallax", Range( -0.01 , 0.01)) = 0
        [Main(z4,_KEYWORD,on,off)]_Back("Back", Float) = 0
        [Tex(z4)]_BackTex("BackTex", 2D) = "white" {}
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

            #define ASE_NEEDS_FRAG_COLOR


            struct appdata_t
            {
                float4 vertex   : POSITION;
                float4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 ase_tangent : TANGENT;
                float3 ase_normal : NORMAL;
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed4 color    : COLOR;
                float2 texcoord  : TEXCOORD0;
                float4 worldPosition : TEXCOORD1;
                float4  mask : TEXCOORD2;
                UNITY_VERTEX_OUTPUT_STEREO
                float4 ase_texcoord3 : TEXCOORD3;
                float4 ase_texcoord4 : TEXCOORD4;
                float4 ase_texcoord5 : TEXCOORD5;
                float4 ase_texcoord6 : TEXCOORD6;
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
            uniform float _Front;
            uniform float _Back;
            uniform float _Main;
            uniform float _Back_Height;
            uniform sampler2D _FrontTex;
            uniform float _FrontHeight_Tiling;
            uniform sampler2D _Front_HeightTex;
            uniform float4 _Front_HeightTex_ST;
            uniform float _Front_Parallax;
            uniform sampler2D _BackTex;
            uniform float _BackHeight_Tiling;
            uniform sampler2D _Back_HeightTex;
            uniform float4 _Back_HeightTex_ST;
            uniform float _Back_Parallax;
            uniform float _Main_Int;
            uniform float4 _MainColor;

            
            v2f vert(appdata_t v )
            {
                v2f OUT;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);

                float3 ase_worldTangent = UnityObjectToWorldDir(v.ase_tangent);
                OUT.ase_texcoord3.xyz = ase_worldTangent;
                float3 ase_worldNormal = UnityObjectToWorldNormal(v.ase_normal);
                OUT.ase_texcoord4.xyz = ase_worldNormal;
                float ase_vertexTangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
                float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
                OUT.ase_texcoord5.xyz = ase_worldBitangent;
                float3 ase_worldPos = mul(unity_ObjectToWorld, float4( (v.vertex).xyz, 1 )).xyz;
                OUT.ase_texcoord6.xyz = ase_worldPos;
                
                
                //setting value to unused interpolator channels and avoid initialization warnings
                OUT.ase_texcoord3.w = 0;
                OUT.ase_texcoord4.w = 0;
                OUT.ase_texcoord5.w = 0;
                OUT.ase_texcoord6.w = 0;

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

            fixed4 frag(v2f IN , bool ase_vface : SV_IsFrontFace) : SV_Target
            {
                //Round up the alpha color coming from the interpolator (to 1.0/256.0 steps)
                //The incoming alpha could have numerical instability, which makes it very sensible to
                //HDR color transparency blend, when it blends with the world's texture.
                const half alphaPrecision = half(0xff);
                const half invAlphaPrecision = half(1.0/alphaPrecision);
                IN.color.a = round(IN.color.a * alphaPrecision)*invAlphaPrecision;

                float2 temp_cast_0 = (_FrontHeight_Tiling).xx;
                float2 texCoord388 = IN.texcoord.xy * temp_cast_0 + float2( 0,0 );
                float2 uv_Front_HeightTex = IN.texcoord.xy * _Front_HeightTex_ST.xy + _Front_HeightTex_ST.zw;
                float4 break412 = tex2D( _Front_HeightTex, uv_Front_HeightTex );
                float3 ase_worldTangent = IN.ase_texcoord3.xyz;
                float3 ase_worldNormal = IN.ase_texcoord4.xyz;
                float3 ase_worldBitangent = IN.ase_texcoord5.xyz;
                float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
                float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
                float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
                float3 ase_worldPos = IN.ase_texcoord6.xyz;
                float3 ase_worldViewDir = UnityWorldSpaceViewDir(ase_worldPos);
                ase_worldViewDir = normalize(ase_worldViewDir);
                float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
                ase_tanViewDir = normalize(ase_tanViewDir);
                float2 Offset390 = ( ( break412.a - 1 ) * ase_tanViewDir.xy * _Front_Parallax ) + texCoord388;
                float2 Offset417 = ( ( break412.a - 1 ) * ase_tanViewDir.xy * _Front_Parallax ) + Offset390;
                float2 Offset418 = ( ( break412.a - 1 ) * ase_tanViewDir.xy * _Front_Parallax ) + Offset417;
                float2 Front001414 = Offset418;
                float4 tex2DNode411 = tex2D( _FrontTex, Front001414 );
                float4 color400 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
                float4 temp_output_376_0 = ( tex2DNode411 * color400 );
                float4 appendResult399 = (float4(temp_output_376_0.rgb , tex2DNode411.a));
                float4 Front363 = saturate( appendResult399 );
                float2 temp_cast_2 = (_BackHeight_Tiling).xx;
                float2 texCoord381 = IN.texcoord.xy * temp_cast_2 + float2( 0,0 );
                float2 uv_Back_HeightTex = IN.texcoord.xy * _Back_HeightTex_ST.xy + _Back_HeightTex_ST.zw;
                float2 Offset380 = ( ( tex2D( _Back_HeightTex, uv_Back_HeightTex ).r - 1 ) * ase_tanViewDir.xy * _Back_Parallax ) + texCoord381;
                float4 tex2DNode370 = tex2D( _BackTex, Offset380 );
                float4 color396 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
                float4 appendResult398 = (float4(( tex2DNode370 * color396 ).rgb , tex2DNode370.a));
                float4 Back362 = ( appendResult398 + float4( 0,0,0,0 ) );
                float4 switchResult359 = (((ase_vface>0)?(Front363):(Back362)));
                float4 Main369 = switchResult359;
                

                half4 color = ( Main369 * _Main_Int * IN.color * _MainColor );

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
Node;AmplifyShaderEditor.CommentaryNode;394;-1871.986,-431.08;Inherit;False;1445.813;366.6067;Comment;6;381;380;385;384;383;395;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;393;-2838.396,-1353.052;Inherit;False;1459.779;390.0759;Comment;7;389;390;386;412;387;388;414;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;378;-385.2805,-833.4958;Inherit;False;1146.391;753.3756;Comment;17;364;365;359;369;373;370;372;362;375;363;376;396;398;399;400;401;411;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;60;1283.173,12.89762;Float;False;True;-1;2;ASEMaterialInspector;0;3;VFXUI/2D/Face;5056123faa0c79b47ab6ad7e8bf059a4;True;Default;0;0;Default;2;True;True;3;1;True;_BlendRGB_Src1;10;True;_BlendRGB_Dst1;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;True;True;True;True;True;0;True;_ColorMask;False;False;False;False;False;False;False;True;True;0;True;_Stencil;255;True;_StencilReadMask;255;True;_StencilWriteMask;0;True;_StencilComp;0;True;_StencilOp;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;2;False;;True;0;True;unity_GUIZTestMode;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;0;;0;0;Standard;0;0;1;True;False;;False;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;1134.981,12.19754;Inherit;False;4;4;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.VertexColorNode;63;832.9807,62.19749;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;80;835.4281,-453.7308;Inherit;False;852;373;Comment;7;87;86;85;84;83;82;81;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;81;1276.259,-404.9379;Inherit;False;Property;_BlendA_Src;BlendA_Src;4;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;1277.259,-323.9379;Inherit;False;Property;_BlendA_Dst;BlendA_Dst;5;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.BlendMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;1016.428,-321.7308;Inherit;False;Property;_BlendRGB_Dst1;BlendRGB_Dst;2;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.BlendMode;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;1013.048,-230.4049;Inherit;False;Property;_BlendONRGB;Blend ON RGB;3;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendOp;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;85;1278.048,-233.4049;Inherit;False;Property;_BlendONA;Blend ON A;6;1;[Enum];Create;True;0;1;Option1;0;1;UnityEngine.Rendering.BlendOp;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;1016.428,-403.7308;Inherit;False;Property;_BlendRGB_Src1;BlendRGB_Src;1;1;[Enum];Create;True;0;0;1;UnityEngine.Rendering.BlendMode;True;2;;;False;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;863.1781,-403.1099;Inherit;False;Property;_Blend;Blend;0;0;Create;True;0;0;0;True;2;Main(z1,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;374;840.915,236.3937;Inherit;False;Property;_Main;Main;7;0;Create;True;0;0;0;True;2;Main(z2,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;983.9807,33.1975;Inherit;False;Property;_Main_Int;Main_Int;8;0;Create;True;0;0;0;False;2;Tex(z2);;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;126;1062.746,153.8431;Inherit;False;Property;_MainColor;MainColor;9;1;[HDR];Create;True;0;0;0;False;1;Tex(z2);False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;364;174.7709,-580.8776;Inherit;False;363;Front;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;365;172.7709,-515.8778;Inherit;False;362;Back;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SwitchByFaceNode;359;354.7735,-549.2961;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;369;537.1119,-554.2974;Inherit;False;Main;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;646.6685,11.61421;Inherit;False;369;Main;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;372;-330.1038,-578.0652;Inherit;False;Property;_Front;Front;13;0;Create;True;0;0;0;True;2;Main(z3,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;381;-1570.364,-379.7669;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxMappingNode;380;-677.1734,-379.3928;Inherit;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;385;-922.5421,-252.4733;Inherit;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;395;-1226.791,-183.1188;Inherit;False;Property;_Back_Height;Back_Height;15;0;Create;True;0;0;0;True;2;Main(z6,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;383;-1821.986,-361.6988;Inherit;False;Property;_BackHeight_Tiling;BackHeight_Tiling;16;0;Create;True;0;0;0;False;1;Tex(z6);False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;373;-331.168,-196.1209;Inherit;False;Property;_Back;Back;19;0;Create;True;0;0;0;True;2;Main(z4,_KEYWORD,on,off);;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;396;17.17944,-244.125;Inherit;False;Constant;_Color0;Color 0;24;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;375;240.6635,-389.9101;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;370;-333.2802,-398.7914;Inherit;True;Property;_BackTex;BackTex;20;0;Create;True;0;0;0;False;2;Tex(z4);;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;401;532.7408,-318.0725;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;398;387.1794,-384.125;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;362;570.4069,-412.2296;Inherit;False;Back;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;363;759.7712,-788.8768;Inherit;False;Front;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;408;684.8674,-684.7678;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;409;-644.0319,-1082.889;Inherit;True;Property;_FrontTex;FrontTex;14;0;Create;True;0;0;0;False;1;Tex(z3);False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;411;-359.3316,-789.0876;Inherit;True;Property;_TextureSample1;Texture Sample 1;24;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;399;522.2794,-789.0248;Inherit;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;384;-1024.542,-327.4733;Inherit;False;Property;_Back_Parallax;Back_Parallax;18;0;Create;True;0;0;0;False;1;Tex(z6);False;0;0;-0.01;0.01;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;415;-547.7417,-760.3806;Inherit;False;414;Front001;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;388;-2634.55,-1298.739;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;387;-2822.171,-1279.671;Inherit;False;Property;_FrontHeight_Tiling;FrontHeight_Tiling;10;0;Create;True;0;0;0;False;2;Tex(z5);;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;386;-2430.113,-1270.352;Inherit;True;Property;_Front_HeightTex;Front_HeightTex;11;0;Create;True;0;0;0;False;1;Tex(z5);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;389;-2409.728,-1069.445;Inherit;False;Property;_Front_Parallax;Front_Parallax;12;0;Create;True;0;0;0;False;1;Tex(z5);False;-0.01;0;-0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;390;-1860.36,-1304.365;Inherit;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ParallaxMappingNode;417;-1853.192,-1131.875;Inherit;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ParallaxMappingNode;418;-1860.192,-961.8755;Inherit;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;414;-1594.072,-1083.417;Inherit;False;Front001;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;391;-2278.728,-899.4453;Inherit;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BreakToComponentsNode;412;-2169.153,-1462.043;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;382;-1023.423,-612.0653;Inherit;True;Property;_Back_HeightTex;Back_HeightTex;17;0;Create;True;0;0;0;False;1;Tex(z6);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;413;-2014.853,-1476.743;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;402;391.6243,-1097.009;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;376;223.832,-784.1202;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;400;-12.82056,-762.125;Inherit;False;Constant;_Color1;Color 1;24;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;410;-364.1319,-1079.489;Inherit;True;Property;_TextureSample0;Texture Sample 0;26;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
WireConnection;60;0;61;0
WireConnection;61;0;78;0
WireConnection;61;1;62;0
WireConnection;61;2;63;0
WireConnection;61;3;126;0
WireConnection;359;0;364;0
WireConnection;359;1;365;0
WireConnection;369;0;359;0
WireConnection;381;0;383;0
WireConnection;380;0;381;0
WireConnection;380;1;382;1
WireConnection;380;2;384;0
WireConnection;380;3;385;0
WireConnection;375;0;370;0
WireConnection;375;1;396;0
WireConnection;370;1;380;0
WireConnection;401;0;398;0
WireConnection;398;0;375;0
WireConnection;398;3;370;4
WireConnection;362;0;401;0
WireConnection;363;0;408;0
WireConnection;408;0;399;0
WireConnection;411;0;409;0
WireConnection;411;1;415;0
WireConnection;399;0;376;0
WireConnection;399;3;411;4
WireConnection;388;0;387;0
WireConnection;390;0;388;0
WireConnection;390;1;412;3
WireConnection;390;2;389;0
WireConnection;390;3;391;0
WireConnection;417;0;390;0
WireConnection;417;1;412;3
WireConnection;417;2;389;0
WireConnection;417;3;391;0
WireConnection;418;0;417;0
WireConnection;418;1;412;3
WireConnection;418;2;389;0
WireConnection;418;3;391;0
WireConnection;414;0;418;0
WireConnection;412;0;386;0
WireConnection;413;0;412;0
WireConnection;413;1;412;3
WireConnection;402;0;376;0
WireConnection;402;1;410;0
WireConnection;376;0;411;0
WireConnection;376;1;400;0
WireConnection;410;0;409;0
ASEEND*/
//CHKSM=22D1AD647C0087D8829D7C1CBDBA9FF3D7503720