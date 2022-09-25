using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AccessShader : MonoBehaviour
{
    public Material mat = null;
    void Start()
    {
        
    }

    public Texture2D texture;
    void Update()
    {
        mat.SetTexture("_MainTex", texture);
        mat.SetFloat("_MossSlider", Mathf.Cos(Time.time) * 0.5f + 0.5f);
    }
}
