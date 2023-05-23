Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014EE70E89E
	for <lists+linux-block@lfdr.de>; Wed, 24 May 2023 00:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbjEWWGW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 May 2023 18:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjEWWGV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 18:06:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72DE83
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 15:06:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 622126365D
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 22:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD11EC433D2;
        Tue, 23 May 2023 22:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684879579;
        bh=H4Z6+p3JNGqUHa8FqPKN+8aaxwWH0SIQSe1nytndeYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rz4T8ph0Q+vs41SINmiwMTvXQrZnPqpo7Pn0349rJceU8zf1HyEAXY76mKaTqNwEM
         ClH4BbIoIkH+VRhnLB156jHRotL9r+/iAPrT8HMcJXtZi4Q36MxiBLUmA4yPOkQOjG
         xXFHONpt5HIdwUH3Zl37wkN0uMBjqzzVRjfDhgciyIwb6VkiKZSQ0qu7sJ6wO8DQSB
         stuuoc7h5ZtjLj46jMGTyRCXt7BYs0Wdmcf7AEgoyLoYOVO2iLBxEidXoL7lTmvbHf
         hNSe8DzSdimtILvBsuLrPzn6zul3pJRistOIixsVldRP4+cSo1XjFbKNCuq95etL/u
         7tR8XCIr2aUdA==
Date:   Tue, 23 May 2023 22:06:18 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "J. corwin Coburn" <corwin@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        vdo-devel@redhat.com
Subject: Re: [dm-devel] [PATCH v2 02/39] Add the MurmurHash3 fast hashing
 algorithm.
Message-ID: <20230523220618.GA888341@google.com>
References: <20230523214539.226387-1-corwin@redhat.com>
 <20230523214539.226387-3-corwin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523214539.226387-3-corwin@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23, 2023 at 05:45:02PM -0400, J. corwin Coburn wrote:
> MurmurHash3 is a fast, non-cryptographic, 128-bit hash. It was originally
> written by Austin Appleby and placed in the public domain. This version has
> been modified to produce the same result on both big endian and little
> endian processors, making it suitable for use in portable persistent data.
> 
> Signed-off-by: J. corwin Coburn <corwin@redhat.com>
> ---
>  drivers/md/dm-vdo/murmurhash3.c | 175 ++++++++++++++++++++++++++++++++
>  drivers/md/dm-vdo/murmurhash3.h |  15 +++
>  2 files changed, 190 insertions(+)
>  create mode 100644 drivers/md/dm-vdo/murmurhash3.c
>  create mode 100644 drivers/md/dm-vdo/murmurhash3.h

Do we really need yet another hash algorithm?

xxHash is another very fast non-cryptographic hash algorithm that is already
available in the kernel (lib/xxhash.c).

- Eric
