﻿using UnityEngine;

/// <summary>
/// Controller for shadow meshes. 
/// Updates the material with shadow receiver plane data.
/// </summary>
[ExecuteInEditMode]
[RequireComponent(typeof(MeshRenderer))]
public class PlanarShadowController : MonoBehaviour
{
    public Transform shadowReceiverPlane;

    private MeshRenderer meshRenderer;

    private void Awake()
    {
        meshRenderer = GetComponent<MeshRenderer>();
    }

    private void Update()
    {
        if (shadowReceiverPlane != null)
        {
            /// Update shader's plane normal vector matrix
            meshRenderer.sharedMaterial.SetVector("_PlaneNormalVectorMatrix", 
                shadowReceiverPlane.transform.worldToLocalMatrix.GetRow(1));
        }
    }
}