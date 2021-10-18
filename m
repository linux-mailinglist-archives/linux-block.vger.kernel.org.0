Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC554325FE
	for <lists+linux-block@lfdr.de>; Mon, 18 Oct 2021 20:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhJRSI5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Oct 2021 14:08:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232349AbhJRSIp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 14:08:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3609F6115A;
        Mon, 18 Oct 2021 18:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634580394;
        bh=7228gZ0KhDyFNT9ETA62dCOAV7WpOBnGE9Zp6DtL3CY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0fd77CSAkbTkDjgYF104/6EysCGnWONICK1TSvLNBhJ52H48YEt2jwCxEIoITfhQ
         6e2fvI+FSPVAlI5S4SFrZSz/VRPKu2302JvEY8+8WJb6tTBVOyvlN/pmeSIRm1hGDF
         QD2NfK7fsBlI95qNC2h0peLa2aASgDlJpVxZvuivBYmMZ/Ly8hsaLkZYNUKIpDvc54
         6RaCIoDwoehLuXeC4OwAo6ncXaVoBwqkIE3gee3200qiVVBgUk3i4of9QoLPWx5Sn1
         /YjtAIyy7DItTTWIAQFBDW60qlf6uaoRECz/nYxRBZ30eMBnam+RS5hZuGV8v8ZosS
         8PuHOQV/777tA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Satya Tangirala <satyaprateek2357@gmail.com>, dm-devel@redhat.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v6 4/4] blk-crypto: update inline encryption documentation
Date:   Mon, 18 Oct 2021 11:04:53 -0700
Message-Id: <20211018180453.40441-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211018180453.40441-1-ebiggers@kernel.org>
References: <20211018180453.40441-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Rework most of inline-encryption.rst to be easier to follow, to correct
some information, to add some important details and remove some
unimportant details, and to take into account the renaming from
blk_keyslot_manager to blk_crypto_profile.

Reviewed-by: Mike Snitzer <snitzer@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/block/inline-encryption.rst | 451 ++++++++++++----------
 1 file changed, 245 insertions(+), 206 deletions(-)

diff --git a/Documentation/block/inline-encryption.rst b/Documentation/block/inline-encryption.rst
index 7f9b40d6b416b..71d1044617a91 100644
--- a/Documentation/block/inline-encryption.rst
+++ b/Documentation/block/inline-encryption.rst
@@ -7,230 +7,269 @@ Inline Encryption
 Background
 ==========
 
-Inline encryption hardware sits logically between memory and the disk, and can
-en/decrypt data as it goes in/out of the disk. Inline encryption hardware has a
-fixed number of "keyslots" - slots into which encryption contexts (i.e. the
-encryption key, encryption algorithm, data unit size) can be programmed by the
-kernel at any time. Each request sent to the disk can be tagged with the index
-of a keyslot (and also a data unit number to act as an encryption tweak), and
-the inline encryption hardware will en/decrypt the data in the request with the
-encryption context programmed into that keyslot. This is very different from
-full disk encryption solutions like self encrypting drives/TCG OPAL/ATA
-Security standards, since with inline encryption, any block on disk could be
-encrypted with any encryption context the kernel chooses.
-
+Inline encryption hardware sits logically between memory and disk, and can
+en/decrypt data as it goes in/out of the disk.  For each I/O request, software
+can control exactly how the inline encryption hardware will en/decrypt the data
+in terms of key, algorithm, data unit size (the granularity of en/decryption),
+and data unit number (a value that determines the initialization vector(s)).
+
+Some inline encryption hardware accepts all encryption parameters including raw
+keys directly in low-level I/O requests.  However, most inline encryption
+hardware instead has a fixed number of "keyslots" and requires that the key,
+algorithm, and data unit size first be programmed into a keyslot.  Each
+low-level I/O request then just contains a keyslot index and data unit number.
+
+Note that inline encryption hardware is very different from traditional crypto
+accelerators, which are supported through the kernel crypto API.  Traditional
+crypto accelerators operate on memory regions, whereas inline encryption
+hardware operates on I/O requests.  Thus, inline encryption hardware needs to be
+managed by the block layer, not the kernel crypto API.
+
+Inline encryption hardware is also very different from "self-encrypting drives",
+such as those based on the TCG Opal or ATA Security standards.  Self-encrypting
+drives don't provide fine-grained control of encryption and provide no way to
+verify the correctness of the resulting ciphertext.  Inline encryption hardware
+provides fine-grained control of encryption, including the choice of key and
+initialization vector for each sector, and can be tested for correctness.
 
 Objective
 =========
 
-We want to support inline encryption (IE) in the kernel.
-To allow for testing, we also want a crypto API fallback when actual
-IE hardware is absent. We also want IE to work with layered devices
-like dm and loopback (i.e. we want to be able to use the IE hardware
-of the underlying devices if present, or else fall back to crypto API
-en/decryption).
-
+We want to support inline encryption in the kernel.  To make testing easier, we
+also want support for falling back to the kernel crypto API when actual inline
+encryption hardware is absent.  We also want inline encryption to work with
+layered devices like device-mapper and loopback (i.e. we want to be able to use
+the inline encryption hardware of the underlying devices if present, or else
+fall back to crypto API en/decryption).
 
 Constraints and notes
 =====================
 
-- IE hardware has a limited number of "keyslots" that can be programmed
-  with an encryption context (key, algorithm, data unit size, etc.) at any time.
-  One can specify a keyslot in a data request made to the device, and the
-  device will en/decrypt the data using the encryption context programmed into
-  that specified keyslot. When possible, we want to make multiple requests with
-  the same encryption context share the same keyslot.
-
-- We need a way for upper layers like filesystems to specify an encryption
-  context to use for en/decrypting a struct bio, and a device driver (like UFS)
-  needs to be able to use that encryption context when it processes the bio.
-
-- We need a way for device drivers to expose their inline encryption
-  capabilities in a unified way to the upper layers.
-
-
-Design
-======
-
-We add a struct bio_crypt_ctx to struct bio that can
-represent an encryption context, because we need to be able to pass this
-encryption context from the upper layers (like the fs layer) to the
-device driver to act upon.
-
-While IE hardware works on the notion of keyslots, the FS layer has no
-knowledge of keyslots - it simply wants to specify an encryption context to
-use while en/decrypting a bio.
-
-We introduce a keyslot manager (KSM) that handles the translation from
-encryption contexts specified by the FS to keyslots on the IE hardware.
-This KSM also serves as the way IE hardware can expose its capabilities to
-upper layers. The generic mode of operation is: each device driver that wants
-to support IE will construct a KSM and set it up in its struct request_queue.
-Upper layers that want to use IE on this device can then use this KSM in
-the device's struct request_queue to translate an encryption context into
-a keyslot. The presence of the KSM in the request queue shall be used to mean
-that the device supports IE.
-
-The KSM uses refcounts to track which keyslots are idle (either they have no
-encryption context programmed, or there are no in-flight struct bios
-referencing that keyslot). When a new encryption context needs a keyslot, it
-tries to find a keyslot that has already been programmed with the same
-encryption context, and if there is no such keyslot, it evicts the least
-recently used idle keyslot and programs the new encryption context into that
-one. If no idle keyslots are available, then the caller will sleep until there
-is at least one.
-
-
-blk-mq changes, other block layer changes and blk-crypto-fallback
-=================================================================
-
-We add a pointer to a ``bi_crypt_context`` and ``keyslot`` to
-struct request. These will be referred to as the ``crypto fields``
-for the request. This ``keyslot`` is the keyslot into which the
-``bi_crypt_context`` has been programmed in the KSM of the ``request_queue``
-that this request is being sent to.
-
-We introduce ``block/blk-crypto-fallback.c``, which allows upper layers to remain
-blissfully unaware of whether or not real inline encryption hardware is present
-underneath. When a bio is submitted with a target ``request_queue`` that doesn't
-support the encryption context specified with the bio, the block layer will
-en/decrypt the bio with the blk-crypto-fallback.
-
-If the bio is a ``WRITE`` bio, a bounce bio is allocated, and the data in the bio
-is encrypted stored in the bounce bio - blk-mq will then proceed to process the
-bounce bio as if it were not encrypted at all (except when blk-integrity is
-concerned). ``blk-crypto-fallback`` sets the bounce bio's ``bi_end_io`` to an
-internal function that cleans up the bounce bio and ends the original bio.
-
-If the bio is a ``READ`` bio, the bio's ``bi_end_io`` (and also ``bi_private``)
-is saved and overwritten by ``blk-crypto-fallback`` to
-``bio_crypto_fallback_decrypt_bio``.  The bio's ``bi_crypt_context`` is also
-overwritten with ``NULL``, so that to the rest of the stack, the bio looks
-as if it was a regular bio that never had an encryption context specified.
-``bio_crypto_fallback_decrypt_bio`` will decrypt the bio, restore the original
-``bi_end_io`` (and also ``bi_private``) and end the bio again.
-
-Regardless of whether real inline encryption hardware is used or the
+- We need a way for upper layers (e.g. filesystems) to specify an encryption
+  context to use for en/decrypting a bio, and device drivers (e.g. UFSHCD) need
+  to be able to use that encryption context when they process the request.
+  Encryption contexts also introduce constraints on bio merging; the block layer
+  needs to be aware of these constraints.
+
+- Different inline encryption hardware has different supported algorithms,
+  supported data unit sizes, maximum data unit numbers, etc.  We call these
+  properties the "crypto capabilities".  We need a way for device drivers to
+  advertise crypto capabilities to upper layers in a generic way.
+
+- Inline encryption hardware usually (but not always) requires that keys be
+  programmed into keyslots before being used.  Since programming keyslots may be
+  slow and there may not be very many keyslots, we shouldn't just program the
+  key for every I/O request, but rather keep track of which keys are in the
+  keyslots and reuse an already-programmed keyslot when possible.
+
+- Upper layers typically define a specific end-of-life for crypto keys, e.g.
+  when an encrypted directory is locked or when a crypto mapping is torn down.
+  At these times, keys are wiped from memory.  We must provide a way for upper
+  layers to also evict keys from any keyslots they are present in.
+
+- When possible, device-mapper devices must be able to pass through the inline
+  encryption support of their underlying devices.  However, it doesn't make
+  sense for device-mapper devices to have keyslots themselves.
+
+Basic design
+============
+
+We introduce ``struct blk_crypto_key`` to represent an inline encryption key and
+how it will be used.  This includes the actual bytes of the key; the size of the
+key; the algorithm and data unit size the key will be used with; and the number
+of bytes needed to represent the maximum data unit number the key will be used
+with.
+
+We introduce ``struct bio_crypt_ctx`` to represent an encryption context.  It
+contains a data unit number and a pointer to a blk_crypto_key.  We add pointers
+to a bio_crypt_ctx to ``struct bio`` and ``struct request``; this allows users
+of the block layer (e.g. filesystems) to provide an encryption context when
+creating a bio and have it be passed down the stack for processing by the block
+layer and device drivers.  Note that the encryption context doesn't explicitly
+say whether to encrypt or decrypt, as that is implicit from the direction of the
+bio; WRITE means encrypt, and READ means decrypt.
+
+We also introduce ``struct blk_crypto_profile`` to contain all generic inline
+encryption-related state for a particular inline encryption device.  The
+blk_crypto_profile serves as the way that drivers for inline encryption hardware
+advertise their crypto capabilities and provide certain functions (e.g.,
+functions to program and evict keys) to upper layers.  Each device driver that
+wants to support inline encryption will construct a blk_crypto_profile, then
+associate it with the disk's request_queue.
+
+The blk_crypto_profile also manages the hardware's keyslots, when applicable.
+This happens in the block layer, so that users of the block layer can just
+specify encryption contexts and don't need to know about keyslots at all, nor do
+device drivers need to care about most details of keyslot management.
+
+Specifically, for each keyslot, the block layer (via the blk_crypto_profile)
+keeps track of which blk_crypto_key that keyslot contains (if any), and how many
+in-flight I/O requests are using it.  When the block layer creates a
+``struct request`` for a bio that has an encryption context, it grabs a keyslot
+that already contains the key if possible.  Otherwise it waits for an idle
+keyslot (a keyslot that isn't in-use by any I/O), then programs the key into the
+least-recently-used idle keyslot using the function the device driver provided.
+In both cases, the resulting keyslot is stored in the ``crypt_keyslot`` field of
+the request, where it is then accessible to device drivers and is released after
+the request completes.
+
+``struct request`` also contains a pointer to the original bio_crypt_ctx.
+Requests can be built from multiple bios, and the block layer must take the
+encryption context into account when trying to merge bios and requests.  For two
+bios/requests to be merged, they must have compatible encryption contexts: both
+unencrypted, or both encrypted with the same key and contiguous data unit
+numbers.  Only the encryption context for the first bio in a request is
+retained, since the remaining bios have been verified to be merge-compatible
+with the first bio.
+
+To make it possible for inline encryption to work with request_queue based
+layered devices, when a request is cloned, its encryption context is cloned as
+well.  When the cloned request is submitted, it is then processed as usual; this
+includes getting a keyslot from the clone's target device if needed.
+
+blk-crypto-fallback
+===================
+
+It is desirable for the inline encryption support of upper layers (e.g.
+filesystems) to be testable without real inline encryption hardware, and
+likewise for the block layer's keyslot management logic.  It is also desirable
+to allow upper layers to just always use inline encryption rather than have to
+implement encryption in multiple ways.
+
+Therefore, we also introduce *blk-crypto-fallback*, which is an implementation
+of inline encryption using the kernel crypto API.  blk-crypto-fallback is built
+into the block layer, so it works on any block device without any special setup.
+Essentially, when a bio with an encryption context is submitted to a
+request_queue that doesn't support that encryption context, the block layer will
+handle en/decryption of the bio using blk-crypto-fallback.
+
+For encryption, the data cannot be encrypted in-place, as callers usually rely
+on it being unmodified.  Instead, blk-crypto-fallback allocates bounce pages,
+fills a new bio with those bounce pages, encrypts the data into those bounce
+pages, and submits that "bounce" bio.  When the bounce bio completes,
+blk-crypto-fallback completes the original bio.  If the original bio is too
+large, multiple bounce bios may be required; see the code for details.
+
+For decryption, blk-crypto-fallback "wraps" the bio's completion callback
+(``bi_complete``) and private data (``bi_private``) with its own, unsets the
+bio's encryption context, then submits the bio.  If the read completes
+successfully, blk-crypto-fallback restores the bio's original completion
+callback and private data, then decrypts the bio's data in-place using the
+kernel crypto API.  Decryption happens from a workqueue, as it may sleep.
+Afterwards, blk-crypto-fallback completes the bio.
+
+In both cases, the bios that blk-crypto-fallback submits no longer have an
+encryption context.  Therefore, lower layers only see standard unencrypted I/O.
+
+blk-crypto-fallback also defines its own blk_crypto_profile and has its own
+"keyslots"; its keyslots contain ``struct crypto_skcipher`` objects.  The reason
+for this is twofold.  First, it allows the keyslot management logic to be tested
+without actual inline encryption hardware.  Second, similar to actual inline
+encryption hardware, the crypto API doesn't accept keys directly in requests but
+rather requires that keys be set ahead of time, and setting keys can be
+expensive; moreover, allocating a crypto_skcipher can't happen on the I/O path
+at all due to the locks it takes.  Therefore, the concept of keyslots still
+makes sense for blk-crypto-fallback.
+
+Note that regardless of whether real inline encryption hardware or
 blk-crypto-fallback is used, the ciphertext written to disk (and hence the
-on-disk format of data) will be the same (assuming the hardware's implementation
-of the algorithm being used adheres to spec and functions correctly).
-
-If a ``request queue``'s inline encryption hardware claimed to support the
-encryption context specified with a bio, then it will not be handled by the
-``blk-crypto-fallback``. We will eventually reach a point in blk-mq when a
-struct request needs to be allocated for that bio. At that point,
-blk-mq tries to program the encryption context into the ``request_queue``'s
-keyslot_manager, and obtain a keyslot, which it stores in its newly added
-``keyslot`` field. This keyslot is released when the request is completed.
-
-When the first bio is added to a request, ``blk_crypto_rq_bio_prep`` is called,
-which sets the request's ``crypt_ctx`` to a copy of the bio's
-``bi_crypt_context``. bio_crypt_do_front_merge is called whenever a subsequent
-bio is merged to the front of the request, which updates the ``crypt_ctx`` of
-the request so that it matches the newly merged bio's ``bi_crypt_context``. In particular, the request keeps a copy of the ``bi_crypt_context`` of the first
-bio in its bio-list (blk-mq needs to be careful to maintain this invariant
-during bio and request merges).
-
-To make it possible for inline encryption to work with request queue based
-layered devices, when a request is cloned, its ``crypto fields`` are cloned as
-well. When the cloned request is submitted, blk-mq programs the
-``bi_crypt_context`` of the request into the clone's request_queue's keyslot
-manager, and stores the returned keyslot in the clone's ``keyslot``.
+on-disk format of data) will be the same (assuming that both the inline
+encryption hardware's implementation and the kernel crypto API's implementation
+of the algorithm being used adhere to spec and function correctly).
 
+blk-crypto-fallback is optional and is controlled by the
+``CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK`` kernel configuration option.
 
 API presented to users of the block layer
 =========================================
 
-``struct blk_crypto_key`` represents a crypto key (the raw key, size of the
-key, the crypto algorithm to use, the data unit size to use, and the number of
-bytes required to represent data unit numbers that will be specified with the
-``bi_crypt_context``).
-
-``blk_crypto_init_key`` allows upper layers to initialize such a
-``blk_crypto_key``.
-
-``bio_crypt_set_ctx`` should be called on any bio that a user of
-the block layer wants en/decrypted via inline encryption (or the
-blk-crypto-fallback, if hardware support isn't available for the desired
-crypto configuration). This function takes the ``blk_crypto_key`` and the
-data unit number (DUN) to use when en/decrypting the bio.
-
-``blk_crypto_config_supported`` allows upper layers to query whether or not the
-an encryption context passed to request queue can be handled by blk-crypto
-(either by real inline encryption hardware, or by the blk-crypto-fallback).
-This is useful e.g. when blk-crypto-fallback is disabled, and the upper layer
-wants to use an algorithm that may not supported by hardware - this function
-lets the upper layer know ahead of time that the algorithm isn't supported,
-and the upper layer can fallback to something else if appropriate.
-
-``blk_crypto_start_using_key`` - Upper layers must call this function on
-``blk_crypto_key`` and a ``request_queue`` before using the key with any bio
-headed for that ``request_queue``. This function ensures that either the
-hardware supports the key's crypto settings, or the crypto API fallback has
-transforms for the needed mode allocated and ready to go. Note that this
-function may allocate an ``skcipher``, and must not be called from the data
-path, since allocating ``skciphers`` from the data path can deadlock.
-
-``blk_crypto_evict_key`` *must* be called by upper layers before a
-``blk_crypto_key`` is freed. Further, it *must* only be called only once
-there are no more in-flight requests that use that ``blk_crypto_key``.
-``blk_crypto_evict_key`` will ensure that a key is removed from any keyslots in
-inline encryption hardware that the key might have been programmed into (or the blk-crypto-fallback).
+``blk_crypto_config_supported()`` allows users to check ahead of time whether
+inline encryption with particular crypto settings will work on a particular
+request_queue -- either via hardware or via blk-crypto-fallback.  This function
+takes in a ``struct blk_crypto_config`` which is like blk_crypto_key, but omits
+the actual bytes of the key and instead just contains the algorithm, data unit
+size, etc.  This function can be useful if blk-crypto-fallback is disabled.
+
+``blk_crypto_init_key()`` allows users to initialize a blk_crypto_key.
+
+Users must call ``blk_crypto_start_using_key()`` before actually starting to use
+a blk_crypto_key on a request_queue (even if ``blk_crypto_config_supported()``
+was called earlier).  This is needed to initialize blk-crypto-fallback if it
+will be needed.  This must not be called from the data path, as this may have to
+allocate resources, which may deadlock in that case.
+
+Next, to attach an encryption context to a bio, users should call
+``bio_crypt_set_ctx()``.  This function allocates a bio_crypt_ctx and attaches
+it to a bio, given the blk_crypto_key and the data unit number that will be used
+for en/decryption.  Users don't need to worry about freeing the bio_crypt_ctx
+later, as that happens automatically when the bio is freed or reset.
+
+Finally, when done using inline encryption with a blk_crypto_key on a
+request_queue, users must call ``blk_crypto_evict_key()``.  This ensures that
+the key is evicted from all keyslots it may be programmed into and unlinked from
+any kernel data structures it may be linked into.
+
+In summary, for users of the block layer, the lifecycle of a blk_crypto_key is
+as follows:
+
+1. ``blk_crypto_config_supported()`` (optional)
+2. ``blk_crypto_init_key()``
+3. ``blk_crypto_start_using_key()``
+4. ``bio_crypt_set_ctx()`` (potentially many times)
+5. ``blk_crypto_evict_key()`` (after all I/O has completed)
+6. Zeroize the blk_crypto_key (this has no dedicated function)
+
+If a blk_crypto_key is being used on multiple request_queues, then
+``blk_crypto_config_supported()`` (if used), ``blk_crypto_start_using_key()``,
+and ``blk_crypto_evict_key()`` must be called on each request_queue.
 
 API presented to device drivers
 ===============================
 
-A :c:type:``struct blk_keyslot_manager`` should be set up by device drivers in
-the ``request_queue`` of the device. The device driver needs to call
-``blk_ksm_init`` (or its resource-managed variant ``devm_blk_ksm_init``) on the
-``blk_keyslot_manager``, while specifying the number of keyslots supported by
-the hardware.
-
-The device driver also needs to tell the KSM how to actually manipulate the
-IE hardware in the device to do things like programming the crypto key into
-the IE hardware into a particular keyslot. All this is achieved through the
-struct blk_ksm_ll_ops field in the KSM that the device driver
-must fill up after initing the ``blk_keyslot_manager``.
-
-The KSM also handles runtime power management for the device when applicable
-(e.g. when it wants to program a crypto key into the IE hardware, the device
-must be runtime powered on) - so the device driver must also set the ``dev``
-field in the ksm to point to the `struct device` for the KSM to use for runtime
-power management.
-
-``blk_ksm_reprogram_all_keys`` can be called by device drivers if the device
-needs each and every of its keyslots to be reprogrammed with the key it
-"should have" at the point in time when the function is called. This is useful
-e.g. if a device loses all its keys on runtime power down/up.
-
-If the driver used ``blk_ksm_init`` instead of ``devm_blk_ksm_init``, then
-``blk_ksm_destroy`` should be called to free up all resources used by a
-``blk_keyslot_manager`` once it is no longer needed.
+A device driver that wants to support inline encryption must set up a
+blk_crypto_profile in the request_queue of its device.  To do this, it first
+must call ``blk_crypto_profile_init()`` (or its resource-managed variant
+``devm_blk_crypto_profile_init()``), providing the number of keyslots.
+
+Next, it must advertise its crypto capabilities by setting fields in the
+blk_crypto_profile, e.g. ``modes_supported`` and ``max_dun_bytes_supported``.
+
+It then must set function pointers in the ``ll_ops`` field of the
+blk_crypto_profile to tell upper layers how to control the inline encryption
+hardware, e.g. how to program and evict keyslots.  Most drivers will need to
+implement ``keyslot_program`` and ``keyslot_evict``.  For details, see the
+comments for ``struct blk_crypto_ll_ops``.
+
+Once the driver registers a blk_crypto_profile with a request_queue, I/O
+requests the driver receives via that queue may have an encryption context.  All
+encryption contexts will be compatible with the crypto capabilities declared in
+the blk_crypto_profile, so drivers don't need to worry about handling
+unsupported requests.  Also, if a nonzero number of keyslots was declared in the
+blk_crypto_profile, then all I/O requests that have an encryption context will
+also have a keyslot which was already programmed with the appropriate key.
+
+If the driver implements runtime suspend and its blk_crypto_ll_ops don't work
+while the device is runtime-suspended, then the driver must also set the ``dev``
+field of the blk_crypto_profile to point to the ``struct device`` that will be
+resumed before any of the low-level operations are called.
+
+If there are situations where the inline encryption hardware loses the contents
+of its keyslots, e.g. device resets, the driver must handle reprogramming the
+keyslots.  To do this, the driver may call ``blk_crypto_reprogram_all_keys()``.
+
+Finally, if the driver used ``blk_crypto_profile_init()`` instead of
+``devm_blk_crypto_profile_init()``, then it is responsible for calling
+``blk_crypto_profile_destroy()`` when the crypto profile is no longer needed.
 
 Layered Devices
 ===============
 
-Request queue based layered devices like dm-rq that wish to support IE need to
-create their own keyslot manager for their request queue, and expose whatever
-functionality they choose. When a layered device wants to pass a clone of that
-request to another ``request_queue``, blk-crypto will initialize and prepare the
-clone as necessary - see ``blk_crypto_insert_cloned_request`` in
-``blk-crypto.c``.
-
-
-Future Optimizations for layered devices
-========================================
-
-Creating a keyslot manager for a layered device uses up memory for each
-keyslot, and in general, a layered device merely passes the request on to a
-"child" device, so the keyslots in the layered device itself are completely
-unused, and don't need any refcounting or keyslot programming. We can instead
-define a new type of KSM; the "passthrough KSM", that layered devices can use
-to advertise an unlimited number of keyslots, and support for any encryption
-algorithms they choose, while not actually using any memory for each keyslot.
-Another use case for the "passthrough KSM" is for IE devices that do not have a
-limited number of keyslots.
-
+Request queue based layered devices like dm-rq that wish to support inline
+encryption need to create their own blk_crypto_profile for their request_queue,
+and expose whatever functionality they choose. When a layered device wants to
+pass a clone of that request to another request_queue, blk-crypto will
+initialize and prepare the clone as necessary; see
+``blk_crypto_insert_cloned_request()``.
 
 Interaction between inline encryption and blk integrity
 =======================================================
@@ -257,7 +296,7 @@ Because there isn't any real hardware yet, it seems prudent to assume that
 hardware implementations might not implement both features together correctly,
 and disallow the combination for now. Whenever a device supports integrity, the
 kernel will pretend that the device does not support hardware inline encryption
-(by essentially setting the keyslot manager in the request_queue of the device
-to NULL). When the crypto API fallback is enabled, this means that all bios with
-and encryption context will use the fallback, and IO will complete as usual.
-When the fallback is disabled, a bio with an encryption context will be failed.
+(by setting the blk_crypto_profile in the request_queue of the device to NULL).
+When the crypto API fallback is enabled, this means that all bios with and
+encryption context will use the fallback, and IO will complete as usual.  When
+the fallback is disabled, a bio with an encryption context will be failed.
-- 
2.33.1

