Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EF4643EA6
	for <lists+linux-block@lfdr.de>; Tue,  6 Dec 2022 09:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbiLFIaw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Dec 2022 03:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbiLFIaT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Dec 2022 03:30:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722671AD8B
        for <linux-block@vger.kernel.org>; Tue,  6 Dec 2022 00:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=cnv4BPx1FyFDTFIp0oJSG5Yl86
        qQKoYfuJweh9v7qGyYV8aRu2XcQx7CMp7QcmzKYnCAY6C9UPgtrICs7fiH77K7xSGgiawZaMamuIg
        +z1TPBs3BaL4nS5jXyZjAkV/oy5Pyd+60KZdQQON22KXEadWUCBktbph7K+Y1AmBgN5e5Muddvl/g
        bkQcSiFotYoEbVBQ3dFfS/I32MGiFW26dPMftpiOeDuuc7L4H43C1eLaQsdgWKbPDur/CYgBdga7A
        jyZLk6ZH5sF3smH3o/8aTEw4B46z7LKBEuUsr/8AyklXUmj3deJmF3yZIcXNVnwSu09JhvWrLtqLp
        H0eBwOVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2TLF-004rO6-2B; Tue, 06 Dec 2022 08:30:17 +0000
Date:   Tue, 6 Dec 2022 00:30:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     luca.boccassi@gmail.com
Cc:     linux-block@vger.kernel.org, jonathan.derrick@linux.dev,
        gmazyland@gmail.com, axboe@kernel.dk, brauner@kernel.org,
        stepan.horacek@gmail.com, hch@infradead.org
Subject: Re: [PATCH v3] sed-opal: allow using IOC_OPAL_SAVE for locking too
Message-ID: <Y479mUU9N3gVz5wC@infradead.org>
References: <20221202003610.100024-1-luca.boccassi@gmail.com>
 <20221206000346.7465-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206000346.7465-1-luca.boccassi@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
