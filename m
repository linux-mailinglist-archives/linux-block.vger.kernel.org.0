Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0E02AEE09
	for <lists+linux-block@lfdr.de>; Wed, 11 Nov 2020 10:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgKKJpr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Nov 2020 04:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKKJpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 04:45:47 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B27C0613D1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 01:45:46 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f38so1128060pgm.2
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 01:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NjIaSEpNiDwwZKuhwZzNWaj2OCWVwqB2zttEUEyFMg4=;
        b=PbeCk8mqq8R8ljKQvWxM7EIloYHLl5nWuSSVBMkChHK8UZ/dYUhcl4uEwMj0sCTWCb
         sNE+qFbF8+SDFGf4ITm2CZR6uO3iDUWvIdRqc3IqORmlIGvKUeGaZKfOe50pFP9mCdFF
         1yCdD/LZGZZFjJdmYDWS304hLkQOtv9vqqLlb/QQ1a9JvXbOT84XTXLC0ASj6BeGAOR/
         ZMWQSVKTikbqkp7m86Cc8r1+Fgm69Uld0shQt+gGUoPUccG0aYWDZRQE4x+OiHeheOBr
         BwzTHifFLCLVtCYVUwD0tphfA877lEFFFJigzdvgeIa9+LMY8/MBVz4x2X9H6YAN7zof
         8knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NjIaSEpNiDwwZKuhwZzNWaj2OCWVwqB2zttEUEyFMg4=;
        b=Ase62BlL46bdftTQsNJeAPjcP5fenVzkEgp6RS6Pqkqw1p0ZFnfGxdniyB4qE71L48
         mrcgf4P6SKx/yXkMZZX2Zlyr/xfZCOFfrZBDb+FXKQdBgJ6g7YJ16tfuDE5eaDPUWhF2
         gS8W7P7YEsnnOfhASa34KCUO7glJtpSqoQXhPK0fKBEae9pszpKIn4cN2Tk0tyl0nJZ0
         tep6c6dG9qo8Y7iownyN5b0FwVXKldcEfWl31V13gn03e+JQRSqSjY4QrcPIgPoENOre
         wBo7xunL0VwLdJjeLdCcXi7K3kkF9UtvM6Ivbz5Njf63VppwvxzTrJzlpjxNpPaYdOBu
         Eayg==
X-Gm-Message-State: AOAM533e0Gzf8X3/QsplyTfm7WFzNgeiqvU2gqJkpuYewPRffb6DEPrp
        OUfzAgvjnn/1XbVJx5IeJEKhpQ==
X-Google-Smtp-Source: ABdhPJzOs8jWe2qmtkaRDl7WfnnhESKVM/Z0So0cZqFQAgHlv7Qy4t6FEcquMk9j87wMLW2VMu4xFg==
X-Received: by 2002:a63:574a:: with SMTP id h10mr21109186pgm.209.1605087946206;
        Wed, 11 Nov 2020 01:45:46 -0800 (PST)
Received: from google.com (154.137.233.35.bc.googleusercontent.com. [35.233.137.154])
        by smtp.gmail.com with ESMTPSA id t74sm1891822pfc.47.2020.11.11.01.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 01:45:45 -0800 (PST)
Date:   Wed, 11 Nov 2020 09:45:38 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH] block/keyslot-manager: prevent crash when num_slots=1
Message-ID: <20201111094538.GA3907007@google.com>
References: <20201111021427.466349-1-ebiggers@kernel.org>
 <20201111092305.GA13004@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111092305.GA13004@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 11, 2020 at 09:23:05AM +0000, Christoph Hellwig wrote:
> On Tue, Nov 10, 2020 at 06:14:27PM -0800, Eric Biggers wrote:
> > +	 * hash_ptr() assumes bits != 0, so ensure the hash table has at least 2
> > +	 * buckets.  This only makes a difference when there is only 1 keyslot.
> > +	 */
> > +	slot_hashtable_size = max(slot_hashtable_size, 2U);
> 
> shouldn't this be a min()?
I think it should be max(), since we want whichever is larger between 2
and the original slot_hashtable_size :)
