Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C0B70E366
	for <lists+linux-block@lfdr.de>; Tue, 23 May 2023 19:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbjEWQ6V (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 May 2023 12:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbjEWQ6T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 12:58:19 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B76D1A1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 09:57:27 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-3f6b20ad49dso11349691cf.2
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 09:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684861046; x=1687453046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cIpc2hkpfcX9ytnNlNra4xHWCIbNM5n2UygyBIAgU8=;
        b=R18c1x7WbsHN+Zw6QGvhDqKDcKvC1wPOSNiwphpcSrr3OhnccsqP/12ovydiwqA9sS
         4Ic41eI7mQEEsz9ivQOjahejS1er21r1EikuRJ9sPf1gFspAF0zvaP2IWXG3TDRvOKPz
         sHd4DxvuBJun+AE6Jb5CYRHKB2No6S2KxC57yta5kn77yAkw3Nez+0obo3g0TDKdOOWW
         CHrYqBu5d7indhqjg0X1HKgndC9xqf7NFOiI3k4Dc6L2P3+u0YaqA1pLssrHOboU6fCn
         LNJVne2VVBIkZISj/nZouyMnNDmqKLm6hUYOx17kN57LtwIDCAHVRsLkZyWsMLlURfKs
         ypUA==
X-Gm-Message-State: AC+VfDz+qj8HJmHms2WOFotyWOhHgpR5ExYxkvuxDaoV12VePECSVLWO
        DBMtcbE/z0KA8i7wioxeCIQ9
X-Google-Smtp-Source: ACHHUZ6FTUIWRZ17w4sgstUiGYRBur4Ios77FwtNmNA/oETp74y448b9irsL1KV98Bhgct8ETOyo4g==
X-Received: by 2002:a05:622a:112:b0:3f5:3a79:f863 with SMTP id u18-20020a05622a011200b003f53a79f863mr23323837qtw.25.1684861046295;
        Tue, 23 May 2023 09:57:26 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id y14-20020a0ceace000000b0062120b054ebsm2930934qvp.19.2023.05.23.09.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:57:25 -0700 (PDT)
Date:   Tue, 23 May 2023 12:57:24 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 18/24] dm: open code dm_get_dev_t in dm_init_init
Message-ID: <ZGzwdLQz5IJUURCH@redhat.com>
References: <20230523074535.249802-1-hch@lst.de>
 <20230523074535.249802-19-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523074535.249802-19-hch@lst.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 23 2023 at  3:45P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> dm_init_init is called from early boot code, and thus lookup_bdev
> will never succeed.  Just open code that call to early_lookup_bdev
> instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
